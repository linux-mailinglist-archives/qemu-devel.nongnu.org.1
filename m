Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B6705726
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:34:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Ph-0003zo-MK; Tue, 16 May 2023 15:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1pz0PY-0003we-FA
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:32:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1pz0PW-0000Y6-TC
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:32:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f4234f67feso2685e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684265556; x=1686857556;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8Qst3DAdo5q7c5FqBTsKayoqHXIJ0q8Ic+PRoQOb8qM=;
 b=6cKD+UIlceAifD5MbSTMVKNs+gDZE8/WoeXLnsKoVGADyn4wOMYbRUHeCQa9vjr7mO
 qo6ahGXzgdclJqypkQX3z7v/l0FbFpp1jGpej+6vkZCOXELampip5JLKYhlS93OIwCRP
 MaCbTBKs/SD9j1rcLpf974V2dy2ARMtgOg8dFnbpjZLCP46FI5Gqo4cRBw4wvHMDA87j
 C+h0PJJUxuzp6/CEqrE8wyXqmG8DcM+zyB7i3oxP2ZkTe0UDV6cv2eSv/m4CzHy0Alre
 qaXzjDIrjJrvi3aedYLpmYrbROw5obQ0vZ1MP3cvnNmUQcm+nPe7Mrq53dd+81ZCakNf
 zb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684265556; x=1686857556;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Qst3DAdo5q7c5FqBTsKayoqHXIJ0q8Ic+PRoQOb8qM=;
 b=U1bvaoKOGieFmEIarGNYviwyMGPIpnYdjDTSxpiEFwGkyujwEhhZ/u90DPBVrg+D0T
 jBUWRnN0EEdPBAqCy60nrAT2qdJH3B+ttnVFl3qFR+Vh3c5bueH39HHoNexBNAhNmpT5
 ZIfW+Ute2k0vaTZwf1vVTPiKZ3LkdTV0pHCM90WqqSa5PowjjvwGkMqDL11I4Wdn/oC9
 iZvTdKW1PDaaiwClQ3uV7kT3BndEYh3V3ZXw1kJZ5ZQfw2rJS0awbwM7ipG8paGxPss1
 zFxv6Z6jbEQdUDVcohjkvwl5yTK2l1KwJ31z9lQEK57m4Brkhfhdvu8AgbPmjxe9WQ8G
 DH9A==
X-Gm-Message-State: AC+VfDwCIiZg+AUq1t2s5xWdnS8DpMJPzfrOvJGxevGYKnvkfdU3aTZY
 wyoX6B4XtmdEVa/npjrXBGZE2A==
X-Google-Smtp-Source: ACHHUZ7P4zJpULsGLfPuK/IOupqigQJywnSK9CTS1e+3r5EjcgZTbhEQ0ty5xs4aXzRzPy2SeXSrkA==
X-Received: by 2002:a05:600c:1ca7:b0:3f1:73b8:b5fe with SMTP id
 k39-20020a05600c1ca700b003f173b8b5femr25286wms.3.1684265556422; 
 Tue, 16 May 2023 12:32:36 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com.
 [34.78.232.44]) by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003f080b2f9f4sm178036wmj.27.2023.05.16.12.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:32:35 -0700 (PDT)
Date: Tue, 16 May 2023 19:32:31 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, jean-philippe@linaro.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Subject: Re: [RFC PATCH v3 08/10] hw/arm/smmuv3: Add CMDs related to stage-2
Message-ID: <ZGPaT0F16kltcL9x@google.com>
References: <20230401104953.1325983-1-smostafa@google.com>
 <20230401104953.1325983-9-smostafa@google.com>
 <ee890a2b-946e-1a04-4f00-b7c60b31af76@redhat.com>
 <ZGJQdp5nVVEGlOzt@google.com>
 <3ffa498c-9702-e905-fcd9-9357ad9aee1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ffa498c-9702-e905-fcd9-9357ad9aee1c@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=smostafa@google.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, May 16, 2023 at 07:04:34PM +0200, Eric Auger wrote:
> >>> +            break;
> >>> +        case SMMU_CMD_TLBI_S12_VMALL:
> >>> +            uint16_t vmid = CMD_VMID(&cmd);
> >> I get
> >> ../hw/arm/smmuv3.c: In function ‘smmuv3_cmdq_consume’:
> >> ../hw/arm/smmuv3.c:1295:13: error: a label can only be part of a
> >> statement and a declaration is not a statement
> >>              uint16_t vmid = CMD_VMID(&cmd);
> >>
> >> you should put the case into a block.
> > Thanks for spotting this, I will fix it.
> > Can you please let me know your config/build commands?
> > as I didn't get errors when compiling it.
> I used a very basic config:
> 
> configure --target-list=aarch64-softmmu --enable-kvm
> --enable-trace-backends=log
Thanks Eric, this builds fine for me, it must be a toolchain thing then.

Thanks,
Mostafa

