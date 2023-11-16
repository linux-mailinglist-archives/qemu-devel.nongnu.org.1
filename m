Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2987EE9F7
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 00:28:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3llU-0005kQ-9o; Thu, 16 Nov 2023 18:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r3llQ-0005jy-FY
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 18:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r3llO-00039C-Re
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 18:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700177229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsVUf95nsvz8HsXCQuGgq3Eei7P+SUSqTDa5H9h4TAs=;
 b=GncoRWWWLsKVCCvVH2ZjTj6G7kf2P/ROh2kX7psMEccwp0nM/CfLy1/+8dG5z1Wdx9e+Ma
 aQEhKAEZw+jGiAYr4zrx7Ir4pb5qSh7cZveMzotMnhM+Plns5SjOZtO6pdcZ8FaJderb2l
 yGWPwnP4Bix5HdeL1NCuxhLZFwZ6i6A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-xnIPiq-pOOGPcDCOgbsK-g-1; Thu, 16 Nov 2023 18:27:08 -0500
X-MC-Unique: xnIPiq-pOOGPcDCOgbsK-g-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1cc23f2226bso15663425ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 15:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700177227; x=1700782027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsVUf95nsvz8HsXCQuGgq3Eei7P+SUSqTDa5H9h4TAs=;
 b=ILyXvF8iEtYbNivETAMx1weq5TBEnBogU9oWe4JHVxH2U5tuXIQH9mciS76LG8co+8
 jLRBTDWLvF7uat1uWdt6lCXEQzMPrnH4l7ULGyrmOH8sLQh7FesQSmxKRuyD5RiyPDcO
 SUpUrgOzqTaYrigpzpEjXAfyrQEE1W4f6MrAefRW4uecnXFzLpbRmfALmhluhgmD1opx
 j2Vxv8X/v+/q/wRG/c6GttJx+ZH+x2tPwBRdf/ZD1dTVWncb9lGJcxh58NpQavGLikfd
 +zzEo5fR02h1YEEOOEGvdxjlrWLFTLEWKLzisYbrhqFlwhaKoeK2oagXH4Sx/fgaIwcP
 CSRg==
X-Gm-Message-State: AOJu0YzIiAY3afSttdCZA4msdOx6PEGJ9Yo+y7WsjNRcUBmoPJUU0IoP
 vyNRdUWegDtn2HNVNJeRkKnP9j8YdrXUnJkgWxUKl1VdpI0Pi7gQIuAmFM1yEeokFsF9oFunudD
 4EuHE+0ALpepi6qU=
X-Received: by 2002:a17:902:ecc8:b0:1cc:3875:e654 with SMTP id
 a8-20020a170902ecc800b001cc3875e654mr12056082plh.26.1700177227017; 
 Thu, 16 Nov 2023 15:27:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3vxHbcjnWTgT6Z/kSUD7c/8W3id7f/D5dsO7xEi1omqLkh+Epr9AU49QKPClN+smHHORp+w==
X-Received: by 2002:a17:902:ecc8:b0:1cc:3875:e654 with SMTP id
 a8-20020a170902ecc800b001cc3875e654mr12056063plh.26.1700177226745; 
 Thu, 16 Nov 2023 15:27:06 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a170903230800b001cc0e3a29a8sm202183plh.89.2023.11.16.15.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 15:27:06 -0800 (PST)
Message-ID: <7252553e-9ab3-4c8e-a867-55c57d0178ba@redhat.com>
Date: Fri, 17 Nov 2023 09:26:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/31] Unified CPU type check
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <efc49f7b-70f5-4ce9-8179-79e8a6abd732@linaro.org>
 <78526851-6d44-4c18-97b8-57462fb42ab7@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <78526851-6d44-4c18-97b8-57462fb42ab7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Phil,

On 11/17/23 02:20, Philippe Mathieu-Daudé wrote:
> On 16/11/23 14:35, Philippe Mathieu-Daudé wrote:
>>
>> I'm queuing patches 1-3 & 5-23 to my cpus-next tree. No need to
>> repost them, please base them on my tree. I'll follow up with the
>> branch link when I finish my testing and push it.
> 
> Here are these patches queued:
> 
>    https://github.com/philmd/qemu.git branches/cpus-next
> 
> I might queue more patches before the 9.0 merge window opens.
> 

Thanks for queuing these patches, but I don't see 'cpus-next' branch
in the repository. Please let me know if I checked out the code properly.

$ git clone https://github.com/philmd/qemu.git philmd
$ cd philmd
$ git branch
* staging
$ git branch -a | grep cpus-next
$ echo $?
1

Thanks,
Gavin


