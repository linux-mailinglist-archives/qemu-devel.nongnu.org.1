Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5D718356
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MCM-00034j-LN; Wed, 31 May 2023 09:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q4MCJ-00033s-JD
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:49:07 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q4MCH-0001Gz-Cd
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:49:07 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-19f9f11ba3dso1349826fac.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685540942; x=1688132942;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VHbBKmYyAje/B6SAPxLoELKDivNe7X3DbmH7Fcmyeb4=;
 b=UAE6EQbKdbidEj3VgdVx1FqICpbU64VI45TRVbHC9VbAL4KEUPtFNRDPVvUjiR3edy
 AkK3BqcvL2Guc2lTXEckCj0bv3D4OCQe5G/CI5/zWSSJFc7g/fWI4GBqk2VyPuqW2QU+
 TH46oen7pb/D1T68XxoGlxt2nFq2m84X2ABqLMShx2rwmcplr9/xrKAjD7BJ+jR9fdOs
 qYMSoxJ1tbKw4r5MvRuqORd0ww9YgHSOfsceEWZBCAl81X5q3EbncoBT3IXv4z06IiE4
 PCQwy+ELXFEXzUruLNdW6SONp52bccz2UIkpkQtKaQtqW518bEe/IL1OPjGq9BJXihuS
 cs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540942; x=1688132942;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VHbBKmYyAje/B6SAPxLoELKDivNe7X3DbmH7Fcmyeb4=;
 b=UGgQLDCGbE4/xh8N/5ZFa7/zyvTLNqQR+KYzNTeSgPgVYCj/f6szjRCGMEWC+GD9BF
 fo8VyE6DSpk+gkqXz4dSJtH5EcZGr1eScJSfIKoReMt0GU9wY6ffX6ZZ5k8Gx+bRq02A
 hoBJz0VbLm2HDjTB2OMUtJUG8dKCQCIxSCDjyItgGel8kM2XKfNf9mCAUAWKfA9hSAXt
 mKQny7T08c/tjNLtRxK66jxqzpqDi9sEThAc9alVqhDIwErdVv498Afup2gBaGwJZ/lm
 nnP94KPjAmQJTPYqpXRly+wA9YfquyJZq4Qfkkiq8fZth/3Wa0HcgztI1QTwb+QFd4mm
 0ACQ==
X-Gm-Message-State: AC+VfDwlkghRbdh89BRU8wtJr1KsKjVQhYUACr9TGA4/nftmz/dfFFpW
 /0+9U6muM2qzA/tVzIjD/rEFJQ==
X-Google-Smtp-Source: ACHHUZ7M+8FQN9cvEM+DSKfi1C2EfSApCDB7nTKEMkLu8AqFR+OG5oCphbjAaUVTEXym4GXSQxhYTQ==
X-Received: by 2002:a05:6871:4e08:b0:19c:b5bc:e868 with SMTP id
 ui8-20020a0568714e0800b0019cb5bce868mr3054190oab.58.1685540942644; 
 Wed, 31 May 2023 06:49:02 -0700 (PDT)
Received: from sunil-laptop ([106.51.186.3]) by smtp.gmail.com with ESMTPSA id
 u8-20020a056870440800b0019ee7417845sm555531oah.9.2023.05.31.06.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 06:49:02 -0700 (PDT)
Date: Wed, 31 May 2023 19:18:53 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Anup Patel <apatel@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 0/3] hw/riscv/virt: pflash improvements
Message-ID: <ZHdQRVidTzxrb6vn@sunil-laptop>
References: <20230526121006.76388-1-sunilvl@ventanamicro.com>
 <CAK9=C2VRF-QobT_-qObOAnjqk8haxOUkmnsPCtCKuRk3pL+jPw@mail.gmail.com>
 <CABJz62M_98hwGSHc2iJ7T+7AT+rQUa4xwc8s1WHo=TTbfCmbGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABJz62M_98hwGSHc2iJ7T+7AT+rQUa4xwc8s1WHo=TTbfCmbGA@mail.gmail.com>
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, May 31, 2023 at 04:34:58AM -0700, Andrea Bolognani wrote:
> On Wed, May 31, 2023 at 10:46:17AM +0530, Anup Patel wrote:
> > On Fri, May 26, 2023 at 5:41 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >   hw/riscv: virt: Assume M-mode FW in pflash0 only when "-bios none"
> > >   riscv/virt: Support using pflash via -blockdev option
> > >   docs/system: riscv: Add pflash usage details
> >
> > In case of KVM guests, there is no M-mode so pflash0 will always
> > contain S-mode FW.
> >
> > I suggest improving this series to consider KVM guests as well
> > such that the same EDK2 S-mode works for KVM and TCG guests.
> 
> After these patches are applied, pflash0 is assumed to contain S-mode
> code *unless* you go out of your way and add -bios none to the
> command line.
> 
> It seems to me that this default behavior will work fine for KVM
> guests too, based on what you wrote above. Isn't that the case?
> 
Hi Andrea,

Actually, KVM boot is supported if the user passes -bios none. Even if
the user doesn't pass -bios at all, the code will itself add none. So,
in either case, it satisfies the condition for ROM/M-mode firmware code
and pflash0 will be assumed to have M-mode firmware code. To resolve
this, I need to add !kvm_enabled() check also while checking for
pflash0. I have made the changes and tested with KVM and KVM guest also
boots with EDK2 now!.

Let me send the next revision with this update. Thanks Anup for pointing
this use case also.

Thanks,
Sunil

