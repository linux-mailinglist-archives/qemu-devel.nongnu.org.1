Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128C71568B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:21:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3teB-00017p-I8; Tue, 30 May 2023 03:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3te1-00017H-Rw
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3te0-0004n8-56
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685431187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aENm/YkSJmXfuyaUV6qyugIrR6R8dIXonfT4zqFDy4I=;
 b=InNnX+e6xo9eFhuorH7V/iJjArVtjHZO4le4Rk1X2k2M6ZCErQ0qrd83NHzuI3qf8bFGgd
 lYNOWlAYelVHfte7MrzvA3GZkXxuLW1mgvHuSJs41D31W2DrBMJA8BBsZAgfyK/ODu2egu
 0epa36pYzXu2zCIStQBQtUQFfoVpsNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-ftu64WyJN_izYIMCfzu9Fg-1; Tue, 30 May 2023 03:19:46 -0400
X-MC-Unique: ftu64WyJN_izYIMCfzu9Fg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30af00323b0so472151f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 00:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685431184; x=1688023184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aENm/YkSJmXfuyaUV6qyugIrR6R8dIXonfT4zqFDy4I=;
 b=Hh0c1DtI45zU/cL1Le8V82/Ut0z1FOnuQOIluNFolKIefMYl+BUdxfp4XAKpMlpcy/
 BV0WHzNVuoRzplQtSWraGn9sc6DuD5mCimv3HHOD25jr+HPXFlRZFYAfYuMAByl49OWR
 +bCcKJ1ik0Ab2gKLe9yG+35S7Vv6/t0Or0giCmKPHdcwIHSubosPrdql4TqMXkwRUXNY
 MnDHBM1+SeCg8OGCK+6MdJCfiXMCHBgrHIxmUPPSk5bw3moe6gwZSzMYIqab7M/HC23F
 J1edyhgX/jzx3veCwIigDiUFXwC46d+9AVOZpCsl1EhlMt3Hn7XLMYjFi56ZNVqpVc96
 EK+Q==
X-Gm-Message-State: AC+VfDzHtMVeS+4p/mALJDWs9Bd2PC6kRVyucSFrD2iyzOHQG3LMV+LR
 daLj9idQWzXKF6ytG1a3wdmJayEXVsTshaaOwpbncDGCEg8J24yZu/WYQwHEr8TDebngW43PAaw
 Ntn0BJmoHCrZAp+8YNBdxOA6JeBDjggoHhkMeWmcHJZDv9LkF2GSgRxvNAbGWSCFJwpg2F/PZ24
 k=
X-Received: by 2002:adf:ce83:0:b0:2c5:3cd2:b8e with SMTP id
 r3-20020adfce83000000b002c53cd20b8emr785818wrn.1.1685431184614; 
 Tue, 30 May 2023 00:19:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4306FLzmak/FgduCAns4AJJ9tpy7YnY8ppPdQG9SMacfMzCRhdxGt9kRN8S3N841ZF4nZmkw==
X-Received: by 2002:adf:ce83:0:b0:2c5:3cd2:b8e with SMTP id
 r3-20020adfce83000000b002c53cd20b8emr785791wrn.1.1685431184233; 
 Tue, 30 May 2023 00:19:44 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 q2-20020a05600000c200b003062c0ef959sm2236527wrx.69.2023.05.30.00.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 00:19:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jonathon Jongsma <jjongsma@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 0/2] block/blkio: support fd passing for
 virtio-blk-vhost-vdpa driver
Date: Tue, 30 May 2023 09:19:39 +0200
Message-Id: <20230530071941.8954-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

v5:
- moved `features` to the object level to simplify libvirt code [Jonathon]
- wrapped a line too long in the documentation [Markus]
- added Stefan R-b tags

v4: https://lore.kernel.org/qemu-devel/20230526150304.158206-1-sgarzare@redhat.com/
- added patch 02 to allow libvirt to discover we support fdset [Markus]
- modified the commit description of patch 01

v3: https://lore.kernel.org/qemu-devel/20230511091527.46620-1-sgarzare@redhat.com/
- use qemu_open() on `path` to simplify libvirt code [Jonathon]
- remove patch 01 since we are not using monitor_fd_param() anymore

v2: https://lore.kernel.org/qemu-devel/20230504092843.62493-1-sgarzare@redhat.com/
- added patch 01 to use monitor_fd_param() in the blkio module
- use monitor_fd_param() to parse the fd like vhost devices [Stefan]

v1: https://lore.kernel.org/qemu-devel/20230502145050.224615-1-sgarzare@redhat.com/

The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the new
'fd' property. Let's expose this to the user, so the management layer
can pass the file descriptor of an already opened vhost-vdpa character
device. This is useful especially when the device can only be accessed
with certain privileges.

Stefano Garzarella (2):
  block/blkio: use qemu_open() to support fd passing for virtio-blk
  qapi: add '@fdset' feature for BlockdevOptionsVirtioBlkVhostVdpa

 meson.build          |  4 ++++
 qapi/block-core.json |  6 +++++
 block/blkio.c        | 53 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 54 insertions(+), 9 deletions(-)

-- 
2.40.1


