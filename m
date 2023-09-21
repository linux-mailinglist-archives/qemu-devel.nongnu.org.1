Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D177A92DF
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFTn-0006ZB-W6; Thu, 21 Sep 2023 04:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFTc-0006YJ-P9
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFTa-0005eQ-Nb
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695286557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXzfBnb6s0TokTe/yNIjNnut/xFJqsbkbtECAXTqWzs=;
 b=aio0qCSws6gVSHi4gXkUqy+VN82irM12V1nrj7sWqyxfERP3Heem7Oigm+ZoHRNQ6Jd5lk
 8tNCYuWdF3AMO5NQNdYYKNrwJQhY6nFqQBuQK+/4LJuMVHakdRLs4QGzAaCuxtlc+SCkMD
 pMUFVt+902fqXKTpqtxGdwPB2L0KOE4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-OlIl11qhNhKEfukrzLInsw-1; Thu, 21 Sep 2023 04:55:55 -0400
X-MC-Unique: OlIl11qhNhKEfukrzLInsw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-404f81fe7cfso7784965e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695286555; x=1695891355;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CXzfBnb6s0TokTe/yNIjNnut/xFJqsbkbtECAXTqWzs=;
 b=LtgdZJoJBMkKdJ5MgwPYQ6/2R5Wygea9SnORjs8KQ0yoCVT3llwMJD+98T+4dK8Qt2
 9P6gqMMYFm0CKuysry0gOkzeWP23uLpjeOaXqdI4lL4zoPewKiSZiybgwqdxKPRmMBLL
 YE0qQFMSPh7yChCGJs4l0HBwnnwn0z7xQmT6ESuTOjtZBGFmAq9UcXyO3Gc5CnpR95Ty
 fI/PO0BwmCgjnORP4J91Arw37jJTlQum1XSg4/ma5H1ZMsFOAuwjbZ6g3XUKOCSaU6zq
 62cbBbRzQY0H6wGotkDRyZrwHcIv94r62CQY9WL0+J5MhDcKKQAfDr2gUgCGV0Our3za
 kQ9w==
X-Gm-Message-State: AOJu0YyhxGes5AwB5HcD/W5z6H1f9LkaE0GEPmzWba3CM6yV8ZFsx4Y7
 jcLvulRssfmkRGIOWRrGdNpGG//bgjAwMIVxxLt1ATBirrfvtnE1vXMf5/14BYSs8s29/vAeXHe
 roUm9cZC2Qebq6Vs=
X-Received: by 2002:adf:f24d:0:b0:314:c6b:b9a2 with SMTP id
 b13-20020adff24d000000b003140c6bb9a2mr4283831wrp.13.1695286554887; 
 Thu, 21 Sep 2023 01:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr1B68OlonHq+x2Ayf/NCpEV9vQxh6aDgWzz7JLCnpauVUgrdLv8UXHvYUV8oS8X50orAakw==
X-Received: by 2002:adf:f24d:0:b0:314:c6b:b9a2 with SMTP id
 b13-20020adff24d000000b003140c6bb9a2mr4283803wrp.13.1695286554511; 
 Thu, 21 Sep 2023 01:55:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626?
 (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de.
 [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
 by smtp.gmail.com with ESMTPSA id
 x5-20020adfdcc5000000b0031c6581d55esm1150709wrm.91.2023.09.21.01.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:55:54 -0700 (PDT)
Message-ID: <678bf0bf-57e7-a596-1ddf-6d0b47cd8677@redhat.com>
Date: Thu, 21 Sep 2023 10:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 02/21] RAMBlock: Add support of KVM private gmem
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-3-xiaoyao.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230914035117.3285885-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 14.09.23 05:50, Xiaoyao Li wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Add KVM gmem support to RAMBlock so both normal hva based memory
> and kvm gmem fd based private memory can be associated in one RAMBlock.
> 
> Introduce new flag RAM_KVM_GMEM. It calls KVM ioctl to create private
> gmem for the RAMBlock when it's set.


But who sets RAM_KVM_GMEM and when? Don't we simply allocate it for all 
RAMBlocks under such special VMs? What's the downside of doing that?


-- 
Cheers,

David / dhildenb


