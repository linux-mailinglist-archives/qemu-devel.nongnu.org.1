Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0394270C4DD
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 20:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19qu-0002xR-2D; Mon, 22 May 2023 14:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q19qf-0002uo-KQ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q19qe-0007te-1a
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684778490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VduVAIEXfCk+g5yzVBb8JD66cuiIAVSiWdbriaSaW+s=;
 b=XGTxCwqwP+H6P7B+a/WS6gyvZNZGNxnN10TjFJ8nqgSLNOzEaOJKOX6nfdVO+yThHmjsRR
 2oC//6lpwylGYxemztyXrOppMNkxDK4rZ2scxj03bGntCOVMljaSHOnc2vt93ixwVFr/nS
 hMQ22gUkcLH/Y7deb8NHArCGeqRW4V4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-YKm9BUo7MMitmSa4HuJlDg-1; Mon, 22 May 2023 14:00:35 -0400
X-MC-Unique: YKm9BUo7MMitmSa4HuJlDg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso627224366b.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 11:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684778417; x=1687370417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VduVAIEXfCk+g5yzVBb8JD66cuiIAVSiWdbriaSaW+s=;
 b=Hs18b/q5CkKRVc52BCMvGDWMC0FAOJIdktblvF4BcEMPn8Vbmjt/pSvzqCIqxGRSiP
 s/iLViV8x+KhWyhddDxM5feC+vtr8iFmNHoyr7oljbLej//DFBCuKO++WvPLbJ8I2aWB
 MXpaBZg64FBGLlqgzp4l2wMDCGZtm2PkjYDldihyNmCqEQQ2uaso0SjQyTnPQ8SdgsX/
 dgSsLPOEPelJs0N8gxttdO3eI5mkRBv0qdklGUx6m8pm5yznjzEAFNp73lKLuPMxTJ8M
 WB8pUxsiMI0hBUm0ej2C9HwH28KZKwKIfqXNvcMsnk26MZIYyNUwqHJjHemTK0diVCBH
 Nb+g==
X-Gm-Message-State: AC+VfDz7MB53/iIGLN5VCBPr3oGWs3TJm8rLflblek1OsX6MoUjb9XjO
 CmRDbHwpk7iotmarTfXC4VwTwowuPDttZJ7+voycxCpxV96C4RF1nP0jmnnG039zWa2uPkbtn2+
 YAcV9OI0IfeqQx0M=
X-Received: by 2002:a17:907:6d8f:b0:96f:7e14:3084 with SMTP id
 sb15-20020a1709076d8f00b0096f7e143084mr9908847ejc.44.1684778417422; 
 Mon, 22 May 2023 11:00:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TXA1tuoaDJqfacfWzLn1zNnsE9Ru4aXvnoAeJlJSt7tBUWWYj4RF155AE/PXNRulOS/CRPQ==
X-Received: by 2002:a17:907:6d8f:b0:96f:7e14:3084 with SMTP id
 sb15-20020a1709076d8f00b0096f7e143084mr9908821ejc.44.1684778417110; 
 Mon, 22 May 2023 11:00:17 -0700 (PDT)
Received: from [192.168.8.105] (tmo-096-217.customers.d1-online.com.
 [80.187.96.217]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170906240e00b00966056bd4f4sm3371877eja.28.2023.05.22.11.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 11:00:16 -0700 (PDT)
Message-ID: <ddc978a1-8edb-f284-4a45-6d10d1b7733a@redhat.com>
Date: Mon, 22 May 2023 20:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] acpi/tests/avocado/bits: enable bios bits avocado tests
 on gitlab CI pipeline
To: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20230517065357.5614-1-anisinha@redhat.com>
 <501EE8C0-D6C2-4FDE-9747-90932F70EB77@redhat.com>
 <20230521015057-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230521015057-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/05/2023 07.51, Michael S. Tsirkin wrote:
> On Fri, May 19, 2023 at 08:44:18PM +0530, Ani Sinha wrote:
>>
>>
>>> On 17-May-2023, at 12:23 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>>
>>> Biosbits avocado tests on gitlab has thus far been disabled because some
>>> packages needed by this test was missing in the container images used by gitlab
>>> CI. These packages have now been added with the commit:
>>>
>>> da9000784c90d ("tests/lcitool: Add mtools and xorriso and remove genisoimage as dependencies")
>>>
>>> Therefore, this change enables bits avocado test on gitlab.
>>> At the same time, the bits cleanup code has also been made more robust with
>>> this change.
>>>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>
>> Michael, did you forget to queue this?
> 
> 
> Not that I forgot but it takes me time to process new patches.
> This came after I started testing the pull.

FYI, I've picked it up today.

  Thomas



