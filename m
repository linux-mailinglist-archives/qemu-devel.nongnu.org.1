Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0974291F
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:08:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtEo-0003Qc-Oc; Thu, 29 Jun 2023 11:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEtEm-0003QN-SB
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEtEi-0001h3-Ax
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688051226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T1VfrjpJNjGz4j/vL9ns63vU7nM5GOXDypXBYsAvRiY=;
 b=NyOn22+ANhy/xEJDXy0c760RTqLGs6U5Vm3E5zE82ll22JP8TKqEIM3tyFjP11AHBFnc23
 OBDjNButRctu/eutWoRti6LYoBy5h0OMHX2a7rQWlHW8WQVJ6MEgIHQ3/IjVBsmrQa9+RG
 ZFwikTKwdnKfoEH9LU9CAQiaVMkJM78=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-PPv6Aig7Pbejqll_mIDbUw-1; Thu, 29 Jun 2023 11:07:00 -0400
X-MC-Unique: PPv6Aig7Pbejqll_mIDbUw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edc7406cbaso741242e87.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688051213; x=1690643213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1VfrjpJNjGz4j/vL9ns63vU7nM5GOXDypXBYsAvRiY=;
 b=Odo4tqWDnkzMPTxj5OIgv/zZ8vPkd6kf7CXMQVBsivWt8hERGLukt0794RGyyCweJj
 eyNx77nkG0QoCF1CR4bsEEwrlpGadXgjcY7JbPJhS6yzXH/PprA/NcS3/fuCP99Vrrfd
 zmrmuClfbQqS/lzGZb/O5YoC/1XOGsN26f+gsBAm1GcvHebV7XL1MzrlnHtarihK8tFB
 aYmcErlL7smJ1vuoydE0OMSIwQppK1faewPg47W7fz5jfZA9vG4TlMvLChvSyTxOF12U
 oYNnAW+IzI1LSbRDCaeSdmEVsru20JAvdMJvJ7cu9bbPz03D0U6AEwLyJVu1zozyvLXa
 UVfA==
X-Gm-Message-State: ABy/qLay533t2WIisCNzeQn1pyK2yTF88uRH/+w1k/0sCA0k+Li051JB
 UsPe5I47mpz/aQ7NwcYby1lryah8xia+XoiXo6w1Nx3XXdlNs4vj2jfLRbY25sjy6l+JLn1rqMa
 cdtte7to/6rOXJSA=
X-Received: by 2002:ac2:5f5b:0:b0:4f8:5755:5b22 with SMTP id
 27-20020ac25f5b000000b004f857555b22mr164394lfz.27.1688051213227; 
 Thu, 29 Jun 2023 08:06:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHFk/xx2lzH+F5RmcCIXWaxwCu8peutLJOOxZ7QKsYzzhW9pyrWZSL4FpWxA3NWSZF6Rxcxjg==
X-Received: by 2002:ac2:5f5b:0:b0:4f8:5755:5b22 with SMTP id
 27-20020ac25f5b000000b004f857555b22mr164378lfz.27.1688051212878; 
 Thu, 29 Jun 2023 08:06:52 -0700 (PDT)
Received: from [192.168.8.100] (tmo-067-34.customers.d1-online.com.
 [80.187.67.34]) by smtp.gmail.com with ESMTPSA id
 u16-20020a7bcb10000000b003fbb5142c4bsm3266197wmj.18.2023.06.29.08.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 08:06:52 -0700 (PDT)
Message-ID: <d09e7410-6bf9-e15b-5759-e111f60e9f19@redhat.com>
Date: Thu, 29 Jun 2023 17:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gitlab: Disable plugins for cross-i386-tci
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230629130844.151453-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230629130844.151453-1-richard.henderson@linaro.org>
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

On 29/06/2023 15.08, Richard Henderson wrote:
> There are timeouts in the cross-i386-tci job that are related to plugins.
> Restrict this job to basic TCI testing.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> E.g. most recent failure(s),
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4565517825
> 4488: make[1]: *** [Makefile:189: run-plugin-memory-with-libbb.so] Error 124
> 4497: make[1]: *** [Makefile:189: run-plugin-memory-with-libempty.so] Error 124
> 4506: make[1]: *** [Makefile:189: run-plugin-memory-with-libinsn.so] Error 124
> 4550: make[1]: *** [Makefile:189: run-plugin-memory-with-libmem.so] Error 124
> 4558: make[1]: *** [Makefile:189: run-plugin-memory-with-libsyscall.so] Error 124
> 
> We do tci+plugin testing with an x86_64 job, so I don't think it's
> important that we cover plugins here.  Mostly we want to make sure
> that TCI *builds* on a 32-bit host.
> 
> Anyway, here's a pass with shared infrastructure,
> https://gitlab.com/rth7680/qemu/-/jobs/4565547513
> 
> There might well be different timings on the project k8s hosts.
> 
> 
> r~
> 
> ---
>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 1e0e6c7f2c..b6ec99ecd1 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -57,7 +57,7 @@ cross-i386-tci:
>     variables:
>       IMAGE: fedora-i386-cross
>       ACCEL: tcg-interpreter
> -    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user
> +    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins
>       MAKE_CHECK_ARGS: check check-tcg
>   
>   cross-mipsel-system:

FWIW,
Acked-by: Thomas Huth <thuth@redhat.com>

I assume you'll apply this directly as a CI fix?


