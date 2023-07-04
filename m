Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 108B3746B2E
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:54:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGar5-0000NG-VJ; Tue, 04 Jul 2023 03:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGar3-0000Mc-Uc
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGar2-00061D-Fq
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688457223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+7xOlDgmj92MLQ3b8vOV86VUcDfMwo2Wn+lhpfE1l8=;
 b=bJ9oCeV0xdU4LzlEi0ezY8edtpoCSPrLF4ZFsitdE43SOMF3SJl6ccz+XMV6NdUcTIikat
 D7GI8XUD6HfQwgelVshVcwVhnqIbO6FLsYNNuzeDm1oleSwl4AUGh/jx9UCHMWE46RSDHK
 YKwwZlEqUrt1PKJGWq8g/RwFe836Fzg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-OgoxBk4ZMr2Z3jRS8Bssrg-1; Tue, 04 Jul 2023 03:53:42 -0400
X-MC-Unique: OgoxBk4ZMr2Z3jRS8Bssrg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3143a431a01so869925f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688457221; x=1691049221;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6+7xOlDgmj92MLQ3b8vOV86VUcDfMwo2Wn+lhpfE1l8=;
 b=S4cgUm10bntd9yAzsXcBapTe0nd7wiHTCvVrRni9T8PK0axjWiDsX7IHzTljdvLH6K
 ygsdS7+cVnCoqg5R6Nshm+2mMHjWQ/145gSZ8+Y2oMMF2utST0vEt+uIgxhyEQWFu1i1
 odvM1wnAOeXrxKcr+fXodlWMQMp+qz0U7f+AYYeezpQkZvWAHUKRp8iIo41GYyhAkroM
 It3sqTVlgAkDRuDrHnHVTi1W4iaGtVnMvlnsuJ4KPZXylZC2c2TmKuXaN6h7PCXtcTyk
 TtyGSMmOZV8SchHDLJ4HFPbStQ4UTwuOnLSdpgycj9uSCDv6omtSYQ+7fVD0NAU0r9eE
 ODLg==
X-Gm-Message-State: ABy/qLY+VzHpm+/QZuFxO+mvLywyuvCkBnCPgBm69xYizNPWh5/2oGAv
 FrEiEU4gI03HdfWK5ifVBB07hgw1Y4S/Kqg6ADxLt8oCvVpVz3Pw6WG1Md0C2RfxFS/f8SWLqpZ
 VeqbPjrpNhtamvjc=
X-Received: by 2002:a5d:668a:0:b0:313:f1a4:4112 with SMTP id
 l10-20020a5d668a000000b00313f1a44112mr9398523wru.33.1688457221164; 
 Tue, 04 Jul 2023 00:53:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG81sRG3riDqeOQLrd4jWc2JYH1+PMpRo2iaf3mRbdeuGdQo+TQIDkF6t7LsJbtj3DfSzD15g==
X-Received: by 2002:a5d:668a:0:b0:313:f1a4:4112 with SMTP id
 l10-20020a5d668a000000b00313f1a44112mr9398510wru.33.1688457220791; 
 Tue, 04 Jul 2023 00:53:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 w10-20020adfec4a000000b00314172ba213sm13141819wrn.108.2023.07.04.00.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:53:40 -0700 (PDT)
Message-ID: <bf01dde1-e08a-2cdb-8489-b7814f419c0c@redhat.com>
Date: Tue, 4 Jul 2023 09:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/12] target/s390x: Fix LRA when DAT is off
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-7-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-7-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
> LRA should perform DAT regardless of whether it's on or off.
> Disable DAT check for MMU_S390_LRA.
> 
> Fixes: defb0e3157af ("s390x: Implement opcode helpers")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/mmu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index b04b57c2356..fbb2f1b4d48 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -417,7 +417,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>   
>       vaddr &= TARGET_PAGE_MASK;
>   
> -    if (!(env->psw.mask & PSW_MASK_DAT)) {
> +    if (rw != MMU_S390_LRA && !(env->psw.mask & PSW_MASK_DAT)) {
>           *raddr = vaddr;
>           goto nodat;
>       }

Interesting

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


