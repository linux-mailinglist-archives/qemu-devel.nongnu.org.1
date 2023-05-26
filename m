Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF371290D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YyN-0004I2-Jr; Fri, 26 May 2023 11:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2YyI-0004He-6k
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2YyF-00068t-A0
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685113390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vjK/Po5jUs6hTvVB+ALvWn2yxOiB3MQlSmznngmwPyI=;
 b=Rrl2kJQXltySwnEgPNsG8Em15JglShhODrUpjR/kYLtyN0G3TCXNRz7XUcnXEVEJ/1+RMB
 wepMqyS8wpE1xHoKoSfdylTmIYyvD2rCey4ib9IoFaXrXn3Y/T7SU6jrvdZBjLBzGKsstX
 lB5RKti8Mvt2qYCkUb77G9cs41wSG8I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-_HD6osrtMGSJw9CJKpS5qw-1; Fri, 26 May 2023 11:03:09 -0400
X-MC-Unique: _HD6osrtMGSJw9CJKpS5qw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f6944c529so82278666b.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685113387; x=1687705387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjK/Po5jUs6hTvVB+ALvWn2yxOiB3MQlSmznngmwPyI=;
 b=cNujULxnlYl/v+bs5THsu6joNIefRYbFPqt2EhC6x+chfs4Va1R9ime8/xnaUbr2ZB
 Xx8skevDRxw5sajlSr+1DJTfOdgABd6GpS7cP+t8/QRPU2zOoOI3PT1H2G5K2/a/WuPE
 X04OEbtTQxh/JwlAro2jF9Ez5+oauAxp5Gd+D2q4YcjBYBl0jZwTMRcI8D5bUbUy5IpW
 pMScSXizXLEerdsNah9G7sydXuRBpxNMAwGqdx/T+JMQMKTiN5m0uZrEOxyX8UTMbiCz
 /EZW+w/kfVVF9YlPNCf8Xt3KEg4/5HlqADy2SeAkP1idn70E5LXCufB6bgHAs5q5LrEx
 u0bQ==
X-Gm-Message-State: AC+VfDzRKGDLnXA0Y/P8yRBye/MFqxM6HgEhmxRLNtiLngMknbszfVxA
 o7qKgDY9nMrSMS5dgF6ZBkDKW/cB9QK9a03ef9BMMtGRvzxG2iP8hX9Kznvlw4yThgVTnkfByf2
 k+A2bBJD08WhwF7O8l75llIGRyRSQQW/WC2/CqgiI/WX+zcE03rp4hg7TOR91EJy46L7kLFDtK4
 4=
X-Received: by 2002:a17:907:7f0c:b0:96f:44b0:b3b7 with SMTP id
 qf12-20020a1709077f0c00b0096f44b0b3b7mr2789728ejc.7.1685113387460; 
 Fri, 26 May 2023 08:03:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5fDmsqvVfSqefIDzJeXmlWUWG+EhLNWX5HD6EkMXhmcF16Xkp7eRJAyaN4kklB2X1uX+sc7A==
X-Received: by 2002:a17:907:7f0c:b0:96f:44b0:b3b7 with SMTP id
 qf12-20020a1709077f0c00b0096f44b0b3b7mr2789670ejc.7.1685113386951; 
 Fri, 26 May 2023 08:03:06 -0700 (PDT)
Received: from step1.. (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 me21-20020a170906aed500b0096a16e49b0fsm2232366ejb.51.2023.05.26.08.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 08:03:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathon Jongsma <jjongsma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 0/2] block/blkio: support fd passing for
 virtio-blk-vhost-vdpa driver
Date: Fri, 26 May 2023 17:03:02 +0200
Message-Id: <20230526150304.158206-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

v4:
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
 qapi/block-core.json |  8 ++++++-
 block/blkio.c        | 53 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 10 deletions(-)

-- 
2.40.1


