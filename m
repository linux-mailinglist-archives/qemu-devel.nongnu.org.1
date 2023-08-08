Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 944D477394E
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 11:20:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTIsq-0005oW-U8; Tue, 08 Aug 2023 05:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTIso-0005ns-Lk
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:20:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTIsn-00053y-4A
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:20:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe5695b180so19848735e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691486403; x=1692091203;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQrG4NDvqnRB3Ql0VCFl7GTefCUbo4h7Y1///eEicjg=;
 b=Kk+XqO8JDMA8yff9Ee4HQX4sZ726Pk1cnTTT8oOLkpx8WPkEss+yB+sdNCpuYNb5sP
 dHQFbVph/aZKcpJkr/nL8aJqwhPc1qfCJEmuvmuteChjxeO73vp5wxo95ELPQjprzSv8
 rb6KZpqDZRffClbzs/SE4oMkl8knDtQ0Ak9rxyfCfZOz/g/0XhIcNYCo+kb9RDcK3gah
 ffWuZEGLxKYjR48FAoef4NGb/vX+W7UXg+XKzYKdv7xumzKr6Awax8CABNEsiycSfMBB
 YDgBv57iiLIUPZ5W0HlSG3jQr2ntdFBpZKo2EOEuyX6cx9cMpG8fmk0TkTHDAa7STZJb
 OdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691486403; x=1692091203;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wQrG4NDvqnRB3Ql0VCFl7GTefCUbo4h7Y1///eEicjg=;
 b=ZV09InQC2r/h0wMnUW0/uarONu+U4eYCvYI+FBDmMEgDmgvjl9IJr3W5lxaN27Tdl4
 LT2Bvb2K+kB7NjyXjZk+ymK083VsDyd8sn2S1DY4PqrSpV9PiVvg7NaijQMRNlApHAPz
 l53MeDguGhnHahDRq6jj9VPRSXrjQcCXy1+x8Rrqer5yWhuJX8unZQpZbWrdpTKsnHXW
 U9RPaBmoIUc5GrZ1L7XcxMaDa9Zm7ln/RAYjSp9PFrto3mRR/c0MFHnqaQ0BnVdtTgja
 WnzrgG+YgHo77gJQ85vKn1DkdrEqoAYbDZi0DZ/IT29te/Ctvm5Uv+5qyHbjtmLRiRbG
 ybug==
X-Gm-Message-State: AOJu0YzdQpx15xFLWRTg3rpJqQ7WJZZzx1lIF7pkepOxH0O9fldfS3sJ
 zzEhQro9OL5oQVgfJlPzAZz+sw==
X-Google-Smtp-Source: AGHT+IFwSwczfYAknYQVuDMKDMGx/sIVrnTCEZVIenwXkM1wnf5x09do9fH8wYPUbnU3CHCNOwLOVw==
X-Received: by 2002:adf:db52:0:b0:314:1560:cc68 with SMTP id
 f18-20020adfdb52000000b003141560cc68mr7205447wrj.56.1691486403365; 
 Tue, 08 Aug 2023 02:20:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a5d67c1000000b0031134bcdacdsm13041841wrw.42.2023.08.08.02.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 02:20:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABDD31FFBB;
 Tue,  8 Aug 2023 10:20:02 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 02/14] linux-user: Define TASK_UNMAPPED_BASE
 in $guest/target_mman.h
Date: Tue, 08 Aug 2023 10:19:58 +0100
In-reply-to: <20230807163705.9848-3-richard.henderson@linaro.org>
Message-ID: <87sf8t99h9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Provide default values that are as close as possible to the
> values used by the guest's kernel.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

