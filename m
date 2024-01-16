Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA382F392
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 18:58:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPngT-0000cl-85; Tue, 16 Jan 2024 12:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rPngP-0000cJ-HW
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:57:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rPngN-00021o-UC
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705427822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5cmppWZbX3pYYv1w15oz1qU+ZqDkj4pnWhawg9wCOE=;
 b=U/oT0P9vtKdg21HsVebf5HzlGXbg85ZTMBH4TEHbA6bo4AlaS1GqV3Z8Hh+mI7bhKzMWWi
 85nXzEFspYiJq1Y7/vwkdFTTW2rHrO3ViDGF2duZU9PvTjNj1mtc1adVh7a95+rtzCxtto
 BLTczbX8zXi+/7KFSXs42N0UHowZVgU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-8DH5dN2bOTeIQdzBgLV-mg-1; Tue, 16 Jan 2024 12:56:26 -0500
X-MC-Unique: 8DH5dN2bOTeIQdzBgLV-mg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7cee760058bso1050262241.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 09:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705427778; x=1706032578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5cmppWZbX3pYYv1w15oz1qU+ZqDkj4pnWhawg9wCOE=;
 b=OFeC4sg/CO0RYGjA1f/tHYHVRjdqSC7PJSR4oLHRr5bsfobeJ3A0f0tVOclcKhmGkq
 0OrORBMxGW6dVklOIwCUFUkS3K43Gs/BDmNiKXUygSWe0j6SEIjZIchNcBekieWFG9FT
 BKmnlZo2hdU32RTnfP3Ir56Jx404XkI/po1/eggZQwmDWhQ9kP5p+H5XxsjaMAYq+5Np
 Cnijfzzasx7qB5//d/Nt8NqxUvOn6RdycS5kIFluGV9D4dXv8+UfgpAh0YMrFNd61Oej
 KwiAfSilTABoePS0nSfWj9iDYEP8vUz4Rqjtxs4C2sqREnqLeR3+RLP7gkv5avlLQw6K
 4pVw==
X-Gm-Message-State: AOJu0YyvsoKhhhyn3sWQdJUsn9Kv18i/QQnJc+hxXvU+tB4SZmw1u05d
 gMcbfqE7ia61SXmtoIBlPAlM2HcnrPmBrXZpERAc3O3ZR5B7jmRg/DQDIF9kzEpGjMAiB2B3f8c
 3EOyH5B7g/14XXuBKl9p5QEKYyhBwLxfRWb5cXUc=
X-Received: by 2002:a05:6122:1b05:b0:4b7:209d:4b2e with SMTP id
 er5-20020a0561221b0500b004b7209d4b2emr4170096vkb.22.1705427777926; 
 Tue, 16 Jan 2024 09:56:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeGnrmLEXJ5xH4RKaNcrL7XM5W4EB+qiNzOzWg+v2/1qS3E/NMpV2KVjTIeXYAzW+bAfveK/aBw3EsKnYnYUU=
X-Received: by 2002:a05:6122:1b05:b0:4b7:209d:4b2e with SMTP id
 er5-20020a0561221b0500b004b7209d4b2emr4170084vkb.22.1705427777671; Tue, 16
 Jan 2024 09:56:17 -0800 (PST)
MIME-Version: 1.0
References: <8cceee40e32dab3e1913e50c221475ea@trimaso.com.mx>
 <CAJSP0QX-5ZxxiNejwEUoPE6Gnn=2=tfOb4MpAJNz5j6FYoNGzQ@mail.gmail.com>
In-Reply-To: <CAJSP0QX-5ZxxiNejwEUoPE6Gnn=2=tfOb4MpAJNz5j6FYoNGzQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2024 18:56:06 +0100
Message-ID: <CABgObfbr3kF44ACA0didBCiBgQ87wgJS_H2fAPwyf==CAD3d2g@mail.gmail.com>
Subject: Re: Qemu setting "-cpu host" seems broken with Windows vms
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: xtec@trimaso.com.mx, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Fri, Dec 29, 2023 at 2:10=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
> > First, performance: since some years ago, since prior to qemu 6.2 until
> > latest 8.2, win10 and win11 vms always worked slower than expected. Thi=
s
> > could be noticed by comparing booting/starting times between vm and a
> > bare metal installation, but I particularly measured it when installing
> > windows cumulative updates through windows update. On vm, from
> > downloading to finishing rebooting it always took 1.5 circa 1.5 hours,
> > while just 40 minutes on bare metal.

One possibility is that you have Hyper-V enabled with -cpu host but
not with other CPU models. That's because "-cpu host" enables nested
virtualization.

Try "-cpu host,-vmx" and it should be clear if that's the case.

Based on the pastie that you prepared, that's the main difference
between -cpu host and -cpu Broadwell-noTSX-IBRS. Nothing else (see
list below) should have any substantial performance impact; even less
so should they make things worse.

Paolo

               "avx512-vp2intersect": true,
               "avx512-vpopcntdq": true,
               "avx512bitalg": true,
               "avx512bw": true,
               "avx512cd": true,
               "avx512dq": true,
               "avx512f": true,
               "avx512ifma": true,
               "avx512vbmi": true,
               "avx512vbmi2": true,
               "avx512vl": true,
               "avx512vnni": true,
               "full-width-write": true,
               "gfni": true,
               "vaes": true,
               "vpclmulqdq": true,

               "clflushopt": true,
               "clwb": true,

               "fsrm": true,

               "host-cache-info": false,
               "host-phys-bits": true,

               "amd-ssbd": true,
               "amd-stibp": true,
               "arch-capabilities": true,
               "ibpb": true,
               "ibrs": true,
               "ibrs-all": true,
               "ssbd": true,
               "stibp": true,

               "kvm-pv-ipi": true,
               "kvm-pv-sched-yield": true,
               "kvm-pv-tlb-flush": true,
               "kvm-pv-unhalt": true,

               "lmce": true,
               "md-clear": true,
               "mds-no": true,
               "movdir64b": true,
               "movdiri": true,
               "pdcm": true,
               "pdpe1gb": true,

               "pdcm": false,
               "pdpe1gb": false,
               "pku": true,
               "pmu": true,
               "pschange-mc-no": true,
               "rdctl-no": true,
               "rdpid": true,
               "sha-ni": true,
               "ss": true,
               "tsc-adjust": true,
               "umip": true,
               "vmx": true,
               "xgetbv1": true,
               "xsavec": true,
               "xsaves": true,

(skipped everything vmx-related, since they don't matter with vmx
itself being false)


