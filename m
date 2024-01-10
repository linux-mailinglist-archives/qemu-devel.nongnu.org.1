Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA398829335
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 06:11:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNQqg-0000nq-ND; Wed, 10 Jan 2024 00:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.leiming@gmail.com>)
 id 1rNQqe-0000nQ-8O
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 00:09:52 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.leiming@gmail.com>)
 id 1rNQqV-0004Nz-LL
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 00:09:52 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28c179bf45cso3272604a91.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 21:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704863382; x=1705468182; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TXu1lgSVjLAAqP9gWPHXNyMgUpUyuzr2NqOI+V8YgE=;
 b=B6HAbbDacUFCpirXpylTe/HH1735l/hdYm9VM/LcDkm0VdwgDeMUaNBdkXy4IAjYSA
 f1dKZh8Ql4DvGBB+Gqnhl7DRoJPLl5pezl5MfSYrDVg4dxrCdIQWmV9MP1Et8KiC1VEx
 cm3ptfD46HE7sMSoG67cYk367GFX/oXVZPTSxeIIO/TCBjoGX7WTqBnXlV84FklFFuZL
 1slkAd0MzyDY/8f73Q9bxqMriziemSVFSl/dlbE8WN1BfrrafB+chgL7bInomwUJ7KFl
 N0EmApyCDlbvBZaIHfWAjwRIeM04Vz4wcHk0tWutN4eRZidgdWGVxQ4bTW/L0j/gVebu
 kaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704863382; x=1705468182;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TXu1lgSVjLAAqP9gWPHXNyMgUpUyuzr2NqOI+V8YgE=;
 b=UypHgJtowH0cFAwu+cafLixvdnyPjLGIzEwPVXP6GGP9VMpgVwqn/ETKMMoqkfvEfs
 w/lhcc5TERmBiWsEB4Mas3exEWMinq6sxFiPW4VUa6wWfutdAfY2nPdFKrGSt82lLiDC
 20v+x4OLQHahDL67REy2LU0P/K06JAsYXKnjXsHFcaPRuZmlxwdPlIJ/VP+JFP7Mxygy
 ZyGVYT5iIZzSB250iASby0GQOOLsDhC1paDdgcQyWZFEK2ODOmHhk+ygeve+dFO9ixP1
 c9je2i7/mCJCv0D+Iyb7fiKSaJTEtdroUJOD8sS4S3Io53OP5ZfapBKxsLLz/w3MQqKN
 1lKQ==
X-Gm-Message-State: AOJu0YxwhyS3tUdqXZMfbf94EzpqPC3j++iRA7MM8T4zQarj6CGADYGA
 r2WI7KIImzH30HQ/xunUR1NYOOdR97GFGg==
X-Google-Smtp-Source: AGHT+IGLLAQ7xOVSKsTT9b3lrN6e6c+i372O3S7iEDQbQ2yiWRutECY8jskHgXt35UkGlmv2nWoknA==
X-Received: by 2002:a17:90b:150:b0:28d:280a:2ac5 with SMTP id
 em16-20020a17090b015000b0028d280a2ac5mr316696pjb.11.1704863381696; 
 Tue, 09 Jan 2024 21:09:41 -0800 (PST)
Received: from fedora ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sf6-20020a17090b51c600b0028cb82a8da0sm439774pjb.31.2024.01.09.21.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 21:09:41 -0800 (PST)
Date: Wed, 10 Jan 2024 13:09:37 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: qemu-devel@nongnu.org
Cc: linux-block@vger.kernel.org, Hanna Czenczek <hreitz@redhat.com>
Subject: qcow2-rs v0.1 and rublk-qcow2
Message-ID: <ZZ4mkYSPEQQz6JcW@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=tom.leiming@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello,

qcow2-rs[1] is one pure Rust library for reading/writing qcow2 image, it is
based on rsd's[2] internal qcow2 implementation, but with lots of change, so far:

- supports read/write on data file, backing file and compressed image

- block device like interface, minimized read/write unit is aligned with block
size of image, so that direct io can be supported

- l2 table & refcount block load & store in slice way, and the minimized
slice size is block size, and the maximized size is cluster size

- built over Rust async/await, low level IO handling is abstracted by async
traits, and multiple low level io engines can be supported, so far, verified
on tokio-uring[3], raw linux sync IO syscall and io-uring[4] with smol[5]
runtime

Attributed to excellent async/.await, any IO(include meta IO) is handled in
async way actually, but the programming looks just like writing sync code,
so this library can be well-designed & implemented, and it is easy to add
new features & run further optimization with current code base.

rublk-qcow2[6] wires qcow2-rs, libublk-rs[7], smol(LocalExecutor) and io-uring
together, and provides block device interface for qcow2 image in 500 LoC.

Inside rublk-qcow2 async implementation, io-uring future is mapped to
(waker, result) by using unique cqe.user_data as key via HashMap, this easy way
does work, even though it may slow things a bit, but performance is still not
bad. In simple 'fio/t/io_uring $DEV' test, IOPS of rublk-qcow2 is better than
vdpa-virtio-blk by 20% with same setting(cache.direct=on,aio=io_uring) when
reading from fully allocated image in my test VM.

The initial motivation is for supporting rblk-qcow2, but I can’t find any
Rust qcow2 library with read/write support & simple interfaces and efficient
AIOs support, finally it is evolved into one generic qcow2 library. Many
qcow2 test cases are added. Also one utility is included in this project,
which can dump qcow2 meta, show any meta related statistics of the image,
check image meta integrity & host cluster leak, format qcow2 image,
read & write, ...

Any comments are welcome!



[1] qcow2-rs
https://github.com/ublk-org/qcow2-rs

[2] rsd
https://gitlab.com/hreitz/rsd/-/tree/main/src/node/qcow2?ref_type=heads

[3] tokio-uring
https://docs.rs/tokio-uring

[4] io-uring
https://docs.rs/io-uring

[5] smol
https://docs.rs/smol

[6] rublk-qcow2
https://github.com/ublk-org/rublk

[7] libublk-rs
https://github.com/ublk-org/libublk-rs



Thanks, 
Ming

