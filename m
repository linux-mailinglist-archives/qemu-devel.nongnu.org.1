Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 831EA7ADCDF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:15:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoEZ-0007pT-S1; Mon, 25 Sep 2023 12:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkoEX-0007nm-7A
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkoEU-0000KB-UH
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695658490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7TYpatd+73WcDke8sP8ZGJUjuyshMuCmv8QF2XliGQ=;
 b=O5uWUHoMXKIqKPk7m6D/xqWMua+pv+jPHJkANpLGYQmCES0BN10lafO8EhUQ63jhyQVakt
 RWq3yxb/Ru/8NLF0XbAwPWk1FMGTbbcFq2x0B0vLvRfzWn5AI3Ku8XhVyeuuyS/c7jgEdS
 2q5wCVHP4oSNtvP6Q4EWjxhmtyFMR2k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-P2VrBVUaNF6HtYHx5Fm8uw-1; Mon, 25 Sep 2023 12:14:48 -0400
X-MC-Unique: P2VrBVUaNF6HtYHx5Fm8uw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3200597bfc5so5055750f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695658487; x=1696263287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7TYpatd+73WcDke8sP8ZGJUjuyshMuCmv8QF2XliGQ=;
 b=gdVPTwz106cDWR6WjntPwx40XSLmob1O9GyWTn+qE7JguchN3m6Z2OF08fRmQRSqav
 7z57rxGe4zX1CbcBZwyfyROSAf/kHWkWKvDLvA28DGo0oUcCnfG6kSyQdUrtEZx1UMec
 paj78XQYXuGhSUbO8v0O85NNwNntdavGNDKFkE1qNi0CGzdhG/KAI3MEIVhBeHW6gBXu
 hyY+Fc7AsTI+Puy795GyEOzDMl1dMdj/fNEgXu/QuIJXLEvFBEAS/FsVBTaa9gzcaRqe
 lcj0Bb6nIcbMybyVrcUfDSdpmt+B7/Tof6Odz41AXL7r7rHG5RdtUTY30kz7WbYgkdPq
 KXHQ==
X-Gm-Message-State: AOJu0YyNK2+mv65ymYGEAbLvEi5g4CXNetf/LnnODDCtWn0CVfcq5NmO
 AF7pdH+61uqaUO4W80xhh06RAfQ5GKP4eAowg/U84hH6PxMMNdxQm2oDG3KBU+QH0JkY/OoUBfs
 QBNtwZY41maTyTUk=
X-Received: by 2002:a5d:4c85:0:b0:321:4d1d:26f with SMTP id
 z5-20020a5d4c85000000b003214d1d026fmr7075159wrs.29.1695658487163; 
 Mon, 25 Sep 2023 09:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQX8GBPai1ApIZIoM4GgsqXePtV4DmgzzoZ7pJtnyo1dZyrJwUFXctMd9qSq1IRcj2M7FHqg==
X-Received: by 2002:a5d:4c85:0:b0:321:4d1d:26f with SMTP id
 z5-20020a5d4c85000000b003214d1d026fmr7075125wrs.29.1695658486825; 
 Mon, 25 Sep 2023 09:14:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 j2-20020a5d4642000000b00317e77106dbsm12251727wrs.48.2023.09.25.09.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 09:14:46 -0700 (PDT)
Message-ID: <908ae9aa-11fc-8584-bd60-e269a1026e37@redhat.com>
Date: Mon, 25 Sep 2023 18:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/31] configure: ensure dependency for cross-compile setup
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Nicholas Piggin <npiggin@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
 <20230925144854.1872513-9-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230925144854.1872513-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/25/23 16:48, Alex Bennée wrote:
> If we update configure we should make sure we regenerate all the
> compiler details. We should also ensure those details are upto date
> before building the TCG tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configure b/configure
> index e83872571d..a95e0f5767 100755
> --- a/configure
> +++ b/configure
> @@ -1788,6 +1788,8 @@ for target in $target_list; do
>             echo "HOST_GDB_SUPPORTS_ARCH=y" >> "$config_target_mak"
>         fi
>   
> +      echo "$config_target_mak: configure" >> Makefile.prereqs

This in practice is not adding anything; if "configure" changes then 
Makefile's dependency on config-host.mak will trigger a configure rerun 
anyway.

If you want to add it, you should also add it for other config-*.mak 
files.  However, I'd remove this line and just change

-# 1. ensure config-host.mak is up-to-date
+# 1. ensure config-host.mak is up-to-date.  All other config-*.mak
+# files for subdirectories will be updated as well.

in the Makefile.

Paolo


