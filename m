Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1B78E72B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbc5H-0001bu-Mq; Thu, 31 Aug 2023 03:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qbc5D-0001aL-6W
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:27:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qbc56-0005Gx-W9
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:27:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so4282975e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 00:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1693466826; x=1694071626; darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:date:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OJz4XzxHE488qa+AXj2I35PvQCBpLT5HrIfvMhiEUCk=;
 b=X6cwEe0VXi5w+//qWPync761ZIFYHvyFU/e5hZOL2Yzrs/scY0q8rIRl4lmqfod7BA
 WO6BSIWXOdOITkZLlE41b4OKkotq4nEMVYXvwxFxCvbFkXhx9My0o2icn+vnioBcyBBi
 BbF51rEfNWbJ5ypr7WoU85SAKpcSL5mydtzR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693466826; x=1694071626;
 h=mime-version:user-agent:content-transfer-encoding:date:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJz4XzxHE488qa+AXj2I35PvQCBpLT5HrIfvMhiEUCk=;
 b=dvgu5Lt8u8myXx/rV6nJAtJgAwnwaHtgXHARTpJQqnNNMXxNzMlRBlnglKbS5oNZpx
 XjV22PQngZvAoJhmWNyjRw3ZawKbiI7O528DiBh/H8BRkiuYTP6OJThPpUd/NbUZhBE8
 LRyLU94ZEYETKAxTvhlb3/AWWldCsq0Z8L/6/U6I5q9/ixMliy6O5n0P90Ga+/RvjgLL
 rV5x56SUCQ3aAEnhvY/PXV78M/5IfC/7FXsz3X5mM+4kBLPUhyW1DKoE0BHdiih+0mZw
 GTsRgBCzoDiEAaMEDZygk0qgFN6WhVMqhGEUJobzOrxOu2yXS7lbM1Z9wPUaULIZcqiw
 dH4A==
X-Gm-Message-State: AOJu0YxByT3XdrNxPMY9uousuxFRM/lpsaE7WJdkswVB8XsbuiGnafba
 aIP4m3SYezVgr4iDOv/Quq8UcwaRHboz7Ec9Ic8=
X-Google-Smtp-Source: AGHT+IFOiX2JBRae/gJN0giUH/a9lHYewdnDsxKXaDIgh7bNC3XzZWl2s9DEV0Dyn9r43x34Q3ZjyA==
X-Received: by 2002:a05:600c:20d5:b0:401:b493:f7c0 with SMTP id
 y21-20020a05600c20d500b00401b493f7c0mr3721746wmm.2.1693466826401; 
 Thu, 31 Aug 2023 00:27:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:22b:9179:6474:7878?
 ([2001:8b0:aba:5f3c:22b:9179:6474:7878])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfe50e000000b0031c52e81490sm1203567wrm.72.2023.08.31.00.27.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 00:27:04 -0700 (PDT)
Message-ID: <52e5f415f67cb61e736a4555bb9c93fa96ef62eb.camel@linuxfoundation.org>
Subject: qemu-system-ppc failures with glibc 2.38
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: qemu-devel@nongnu.org
Date: Thu, 31 Aug 2023 08:27:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

Yocto Project's CI is noticing a lot of issues with qemu-system-ppc
emulation on loaded systems after we switch glibc to 2.38.

This is manifesting as=C2=A0hangs in the emulated system and for example,
systemd units then timeout and restart. If we have long running
commands running over ssh (e.g. configure or kernel module builds),
these are then are then disconnected.

It does appear the system does 'freeze' periodically. It also seems
related to the load on the system running the emulation. On an
otherwise idle system it is fine, when there is other load, we hit the
freezes, watchdog resets and resulting faiilures.

We do sometimes see kernel rcu stalls too, the frequency of them may be
higher with the new glibc, it is hard to tell.

Can anyone think of something that changed in glibc 2.38 which might
affect qemu-system-ppc in this way? Everything else we test seems ok.

I've tested with qemu 8.0.0, 8.0.3, 8.0.4 and 8.1.0 with similar
results. The latter has other problems unfortunately which we're still
trying to debug (x86 hangs, we then tried the "softmmu: Assert data in
bounds in iotlb_to_section" patches but that breaks mips).=20

Cheers,

Richard

