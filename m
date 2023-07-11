Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D246D74F3C5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFRh-0005Mg-QQ; Tue, 11 Jul 2023 11:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFRf-0005GJ-Hb
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFRR-0006ib-So
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689089897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLvHdrvh5NgLCo+BEJ+it3y42RFQYgoan0DilXLSV50=;
 b=AdMpSKcIFIzWDuesw4m+D500VnS4cp9pK8aqmPCoAIxHH3wnGQOCSGqKamWV2H0Zsaegxk
 hUBppSyE8P/T5YFz1pRqqJcS18eM3qDCXXaxJLogz1gv1y9fqet3fwwN8VhfPHSdzxkSEV
 xAIelJVmQ9uYnzjzymSBqTMiHp2vaKQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-R9dGrhE-OmuVp6_0TbnamA-1; Tue, 11 Jul 2023 11:38:15 -0400
X-MC-Unique: R9dGrhE-OmuVp6_0TbnamA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so36497245e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 08:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689089894; x=1691681894;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OLvHdrvh5NgLCo+BEJ+it3y42RFQYgoan0DilXLSV50=;
 b=FNFmoQyVd43DCvBJHa/e7G+cpS2h2+SfjFK6PTcD9fp9qvIXKOb//sOfk5hckw/ruA
 +qHWyhzLye/PBIEIYebXCW1iiPjfg+pWE2EBHTWi3QIfwjPsU03J3IREYNGdflRHX0hj
 /0twDH4hWdZH80eaGprGRvZ3FiG3Ok+wcVPX7NFoADKimkk8K2lsWL0Am9LMh27AjrjL
 y/wPJrOKaAfebHSJ/PtuE+2XVmIq9CK8WRrvy86RCoUPE9zGEG2vrYBmWW3eqhQDpNMa
 1bF6y5LVBBO0ab3bH/B23DO2wna6+1nsntG8gxFLlbPEVboD1cW2cxOwEMqkf8mF7zaX
 qwJA==
X-Gm-Message-State: ABy/qLbCbn2mE8fsCFJEZXNHnSMa/Uq5yOnr3Ebee2BMzgdbdZQD8QrR
 PK7QYCbu6C/KuShlTQjbBJaQJaKnQ9mjSXxNID6kzjbtDR5tuh4JQxIQ1OzcY00UJ06GFm4jzs4
 I9Q2xeufgqUFtON8=
X-Received: by 2002:a7b:cd96:0:b0:3fc:443:3773 with SMTP id
 y22-20020a7bcd96000000b003fc04433773mr9863623wmj.30.1689089894680; 
 Tue, 11 Jul 2023 08:38:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG1FnOXxRJbNhF3Gv07d7HPNTA/sxeI85nfwne/Y8PWkLdG+tbRy2y4Kwu1H51VVi2Z5A22fA==
X-Received: by 2002:a7b:cd96:0:b0:3fc:443:3773 with SMTP id
 y22-20020a7bcd96000000b003fc04433773mr9863605wmj.30.1689089894380; 
 Tue, 11 Jul 2023 08:38:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d?
 (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de.
 [2003:cb:c745:4000:13ad:ed64:37e6:115d])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b003fbe791a0e8sm2910555wmd.0.2023.07.11.08.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 08:38:13 -0700 (PDT)
Message-ID: <78c1cd8a-eabe-698d-69b1-d9df4d5f5c4b@redhat.com>
Date: Tue, 11 Jul 2023 17:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/7] virtio-mem: Device unplug support
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230711153445.514112-1-david@redhat.com>
 <20230711113716-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230711113716-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11.07.23 17:37, Michael S. Tsirkin wrote:
> On Tue, Jul 11, 2023 at 05:34:38PM +0200, David Hildenbrand wrote:
>> One limitation of virtio-mem is that we cannot currently unplug virtio-mem
>> devices that have all memory unplugged from the VM.
>>
>> Let's properly handle forced unplug (as can be triggered by the VM) and
>> add support for ordinary unplug (requests) of virtio-mem devices that are
>> in a compatible state (no legacy mode, no plugged memory, no plug request).
>>
>> Briefly tested on both, x86_64 and aarch64.
> 
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> feel free to merge.

Will queue tomorrow (and send a PR soonish) if there is no more 
feedback, thanks!

-- 
Cheers,

David / dhildenb


