Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4397FEBA1
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 10:14:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8d66-0002HW-Sj; Thu, 30 Nov 2023 04:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r8d65-0002H7-Bx; Thu, 30 Nov 2023 04:12:37 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r8d63-0007FW-OE; Thu, 30 Nov 2023 04:12:37 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b31232bf0so5491615e9.1; 
 Thu, 30 Nov 2023 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701335553; x=1701940353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=siaYtfcd1nV01H+dRdqoPqqRzYarxavISfuT4qVZzyM=;
 b=kFTW26cB1g+6+yN96YyCagaDNfHoBTGDcERrIwfilgIMLcIVOZI9hrB+b9zt18NlnH
 c7msdklXPzoastVcPEtSrKp7z4JZejdcW1yEZHGlQN7oksqfPwkdrr+Fx+BIP4wotoIE
 AFUqdcK2o4hVrJJlJb+U1fWyijyUdeViFsBbKNfI8tBtJ6VvoXWseyEw6lvslKMsh8UH
 mcdYQX9hFpoHCDAJNmooTcEGkiamL/xB7QZZ5aeUB3zBGdH6yfQEoAUa5eU4ACAjkO5e
 jSw5xzB/S3JpJKD9K2ukUKpobrlBUol1I2PVL/kOCcZci4/N0djmlTjKSlAVlsDxBrf3
 YU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701335553; x=1701940353;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siaYtfcd1nV01H+dRdqoPqqRzYarxavISfuT4qVZzyM=;
 b=llP0gcCzqPjcL5VYTBixOQ5ZLMb2angW52RIFoXE5nWgfgsSyeK7PDYfozIJP2ewBp
 GUj3xkKWNqJFAWkr2vZY3NQUBHLAGPRLYXJvNGNhEvvwgyXBOaV9D7GXaigYTebzvcRn
 VqSrDxX8K+bI3yXZyeAQk/1G/XBFCUzu9Dppe06qWh/PUjKGN7PTSOmBeY+yrSKexAV2
 jsxlsVObha8CJJhnhrFe1MDBWM4Uuwa6cAwPcHYszlXNR7mPoDtcwVSxZXhRtYJG2rlE
 zXg/3+UC81U9YPBZoR8CWSgA39EAdVTWFXYZaUSS9iYTEBNxLi+Smu6DuW7JL2YiEWtP
 j58A==
X-Gm-Message-State: AOJu0Yz5O1wrQ0++jpYz+C6kPGsCScAfafCsSMqUFXsr6t+f1NkXjts9
 2PqDoqKES95OUZHCmIZsFDg=
X-Google-Smtp-Source: AGHT+IHK+u82BOt6ta4eeN8cUN9H4SuoQH8m39Aqnj8S1aTgEt3vYUylXWxM8EvP4Mg+jRJiQRSjlA==
X-Received: by 2002:a05:600c:3110:b0:3f5:fff8:d4f3 with SMTP id
 g16-20020a05600c311000b003f5fff8d4f3mr15366829wmo.7.1701335553272; 
 Thu, 30 Nov 2023 01:12:33 -0800 (PST)
Received: from [192.168.17.21] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a05600c474300b0040b36050f1bsm1227874wmo.44.2023.11.30.01.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 01:12:32 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <bc173dc3-1cdf-43d2-8ab5-9df4dd0a6a51@xen.org>
Date: Thu, 30 Nov 2023 09:12:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] block: remove AioContext locking
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Xie Changlong <xiechanglong.d@gmail.com>, Ari Sundholm <ari@tuxera.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Cleber Rosa <crosa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>
References: <20231129195553.942921-1-stefanha@redhat.com>
 <20231129195553.942921-6-stefanha@redhat.com>
Organization: Xen Project
In-Reply-To: <20231129195553.942921-6-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32f.google.com
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 29/11/2023 19:55, Stefan Hajnoczi wrote:
> This is the big patch that removes
> aio_context_acquire()/aio_context_release() from the block layer and
> affected block layer users.
> 
> There isn't a clean way to split this patch and the reviewers are likely
> the same group of people, so I decided to do it in one patch.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/block/block-global-state.h |   9 +-
>   include/block/block-io.h           |   3 +-
>   include/block/snapshot.h           |   2 -
>   block.c                            | 234 +---------------------
>   block/block-backend.c              |  14 --
>   block/copy-before-write.c          |  22 +--
>   block/export/export.c              |  22 +--
>   block/io.c                         |  45 +----
>   block/mirror.c                     |  19 --
>   block/monitor/bitmap-qmp-cmds.c    |  20 +-
>   block/monitor/block-hmp-cmds.c     |  29 ---
>   block/qapi-sysemu.c                |  27 +--
>   block/qapi.c                       |  18 +-
>   block/raw-format.c                 |   5 -
>   block/replication.c                |  58 +-----
>   block/snapshot.c                   |  22 +--
>   block/write-threshold.c            |   6 -
>   blockdev.c                         | 307 +++++------------------------
>   blockjob.c                         |  18 --
>   hw/block/dataplane/virtio-blk.c    |  10 -
>   hw/block/dataplane/xen-block.c     |  17 +-
>   hw/block/virtio-blk.c              |  45 +----
>   hw/core/qdev-properties-system.c   |   9 -
>   job.c                              |  16 --
>   migration/block.c                  |  33 +---
>   migration/migration-hmp-cmds.c     |   3 -
>   migration/savevm.c                 |  22 ---
>   net/colo-compare.c                 |   2 -
>   qemu-img.c                         |   4 -
>   qemu-io.c                          |  10 +-
>   qemu-nbd.c                         |   2 -
>   replay/replay-debugging.c          |   4 -
>   tests/unit/test-bdrv-drain.c       |  51 +----
>   tests/unit/test-bdrv-graph-mod.c   |   6 -
>   tests/unit/test-block-iothread.c   |  31 ---
>   tests/unit/test-blockjob.c         | 137 -------------
>   tests/unit/test-replication.c      |  11 --
>   util/async.c                       |   4 -
>   util/vhost-user-server.c           |   3 -
>   scripts/block-coroutine-wrapper.py |   3 -
>   tests/tsan/suppressions.tsan       |   1 -
>   41 files changed, 102 insertions(+), 1202 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


