Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A668739A51
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 10:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFtN-0003iz-PY; Thu, 22 Jun 2023 04:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qCFtM-0003im-HS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qCFtL-00010Z-5T
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687423327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Ee2Zv2fMcK4yfv2jz0JENJHk8W5yyRLxl+AAkKoAC0=;
 b=IIigIbV6PNKNxq/7jniEQbi5tjbcMjcTg6gT0c7hkamb9ZpxF6CXG1M991mqzPsi6GjBXX
 voqACZdPZ0JVj1ZxWLYdqFfDET2FSUvMpzj2pCDFCD95LxY/LjdoR/cVuViXoqIscdjd+X
 g9GAlgPDOy5oXaX6ag7D0CkKNbmkHo4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-DG0cB0-7OOSXHeASM52hjA-1; Thu, 22 Jun 2023 04:42:06 -0400
X-MC-Unique: DG0cB0-7OOSXHeASM52hjA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f858280d89so4964026e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 01:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687423324; x=1690015324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ee2Zv2fMcK4yfv2jz0JENJHk8W5yyRLxl+AAkKoAC0=;
 b=A8XKCsPgkT9hZ2Wca/ddQuWecKh7w2rFE8Z5eYQf6O0OVIv6fJDuZHVHxCzgqBCrGN
 KqVuvhYmK31Esw6n3ZlO9Zy+b9BQYHzBgYx03f+q3BuNW7SYTJRbtbqBeJauEfetuf8b
 1mL6qZavQyWAi7+UcqpTjHhzpczlkT+/9caU9U5Yax+sGqG6lWW8CQ8RRca4RxbW3Emq
 UWNaehd523DttcuQ+67LGSBxhHHkFFC6TdscocbpEKcv1xslV7qFNpKtAu5eduam/xHm
 W6IIUoomush+h1AXfxfNL1Qu/QhlTpxtjNwDG5F6I/OGCEK/nc2jYhbgIWyynuntTwDq
 aEOw==
X-Gm-Message-State: AC+VfDz9IGO/G9BLkt6ISjaCUaD5s/qXraMNntj6FVeEZSMbkRuFGuxk
 PUhToWPcDfxU0/aB14feOeoO6q5rmvF7j2APp2Vn9Y6aCu0iu5kl60TJhl0L6fwxWP6SUx60NQQ
 Y5+6m7GiIBl093ko=
X-Received: by 2002:a19:6755:0:b0:4f8:58f4:b96e with SMTP id
 e21-20020a196755000000b004f858f4b96emr11032246lfj.37.1687423324711; 
 Thu, 22 Jun 2023 01:42:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7s9uaL1cFFNyQXUQF3p9qQ/D/B4WHcpAVKANbTVocBMAtOP8J+vVJunxTVG5OOYAhmDP062Q==
X-Received: by 2002:a19:6755:0:b0:4f8:58f4:b96e with SMTP id
 e21-20020a196755000000b004f858f4b96emr11032241lfj.37.1687423324446; 
 Thu, 22 Jun 2023 01:42:04 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 r7-20020adfce87000000b0030af54c5f33sm6435339wrn.113.2023.06.22.01.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 01:42:03 -0700 (PDT)
Message-ID: <2c0f81cc-af61-515d-8d83-84da6f3aefb5@redhat.com>
Date: Thu, 22 Jun 2023 10:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: always build network bootloader
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-8-pbonzini@redhat.com>
 <bcd7bd4829ba2046b7cc8196e8e83fba338f2f94.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <bcd7bd4829ba2046b7cc8196e8e83fba338f2f94.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/06/2023 17.20, Nina Schoetterl-Glausch wrote:
> On Mon, 2023-06-05 at 11:52 +0200, Paolo Bonzini wrote:
>> In the beginning, the network bootloader was considered experimental and
>> thus optional, but it is well established nowadays and configure always
>> checks for roms/SLOF before compiling pc-bios/s390-ccw.
> 
> Only if run in a git repository, not in a tree generated with archive-source.sh
> which doesn't package roms/SLOF.
> So without the check below the build fails.
> This is not inteded, is it?

I guess archive-source.sh needs to be changed to include the SLOF sources 
now? Paolo, what would you recommend?

  Thomas


