Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7217467F7
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 05:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGWoQ-00019X-Fc; Mon, 03 Jul 2023 23:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGWoN-00018w-Hf; Mon, 03 Jul 2023 23:34:43 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGWoL-00032X-UN; Mon, 03 Jul 2023 23:34:43 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a1ebb85f99so4009497b6e.2; 
 Mon, 03 Jul 2023 20:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688441680; x=1691033680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p5FvS4BGnKzuzMNP3/X6ry3FBOUf4j+/0xiQu8qIzbw=;
 b=r2A8x3IwZjBcimrUEaEnqwFUfL/JUmZ0ZJ/wxexSlzkaD63zuNu/VpfLhQJl7ikBBA
 hjoToQ2HS7CnI4cXbYK2tNMMInnRsvckcqJ0IEVYu9iGCxJ2YqieMtWuVVcbWFHcq4Pi
 CL+xHXLWsNBg1iSH7V0rj+N+v01NtoowBZlAOvjHAz+nM9p7YW6BBDo5gw/eP8UZTKSQ
 k45qDX01SezUGbhSiqOO1mD3AEJrJlY+w4MsOZKXGv5KOk8B7obQSRu9+6QCnCZnSD80
 u9tnUWCPl4hfR2AaZzZ+4L2Ms5uJA1oWzTgK9Z9nEoskOasRXcok7Yl0JQhBgvK7/4G9
 7p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688441680; x=1691033680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p5FvS4BGnKzuzMNP3/X6ry3FBOUf4j+/0xiQu8qIzbw=;
 b=iRRlHCSf+T1G+uLCuflF/JKy5pUPJU4Fbhm7bMnz6FnAZXjq/pv+NlskW7kjGT7Gww
 FS5TXZIvHQqi16avko/4O4QYFA/KAUEGGSpFvs2gokz7nztJjIv17mQkYN1UP9HZyf9R
 BudDIyWytjCXRT2v9t7WubBaYC8wVnyEhuXGRWvexIF+l/YLcIRk2BDcnRuv8ljcv9F5
 FVy0qDaGNXPsUM6V4mqJeJ6ce+Y5CoWu04lWvYrAjTZAGm8mD7cWhv5ItAc5yxbZc7GA
 sVG3rtdnbvyMmhGgrXW+bGmAzPFt1B9+TwNjTegurTjXIkz4YpmulLfoTCmtpEaJAOWW
 qmfQ==
X-Gm-Message-State: AC+VfDx7dvbWdWkqN1zUxBH9Z4Saw4JvfNIilbaC5ifrfGJM3EhA5qDQ
 dFGrhb4H7VRXr4enPWPmT+Q=
X-Google-Smtp-Source: ACHHUZ7Bkxfb+fWof/u8gKbliCs6f3vHhT3idmhwAqzjROeGv2xAMWZlq9TDObGyRzIG+aQTvV/CgQ==
X-Received: by 2002:a05:6808:2126:b0:3a0:4ff2:340 with SMTP id
 r38-20020a056808212600b003a04ff20340mr13080062oiw.57.1688441680026; 
 Mon, 03 Jul 2023 20:34:40 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 16-20020a630f50000000b00553c09cc795sm15087476pgp.50.2023.07.03.20.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 20:34:39 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH v3 0/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR
Date: Tue,  4 Jul 2023 11:34:32 +0800
Message-Id: <cover.1688438055.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

According to VirtIO standard, "The class, command and
command-specific-data are set by the driver,
and the device sets the ack byte.
There is little it can do except issue a diagnostic
if ack is not VIRTIO_NET_OK."

Therefore, QEMU should stop sending the queued SVQ commands and
cancel the device startup if the device's ack is not VIRTIO_NET_OK.

Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patchset fixes this problem by returning -EIO when the device's
ack is not VIRTIO_NET_OK.

Changelog
=========
v3:
 - split the fixes suggested by Eugenio
 - return -EIO suggested by Michael

v2: https://lore.kernel.org/all/69010e9ebb5e3729aef595ed92840f43e48e53e5.1687875592.git.yin31149@gmail.com/
 - fix the same bug in vhost_vdpa_net_load_offloads()

v1: https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/

Hawkins Jiawei (3):
  vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
  vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
  vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_offloads()

 net/vhost-vdpa.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.25.1


