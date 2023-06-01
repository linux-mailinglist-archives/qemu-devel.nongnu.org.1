Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4EF719141
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YqK-0007Ko-QT; Wed, 31 May 2023 23:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q4YqJ-0007Kf-KV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:19:15 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q4YqH-0003B7-Rv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:19:15 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d2a87b9daso262601b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685589552; x=1688181552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FrfFhcpCDB+Tgl6xUiFVZLlSppgb/hsoX/FxVOIbZUk=;
 b=z1bUqRtFniqO+bDSlNVkZdAPV7g6hOQkUnZEIvrkOpa1HB1WNNSeN+5GTor/T6EdBn
 9rZ1e3RoJk8fMmy0+yMVpIgUAJZC3kR34QzL4JKGdEQQw+wZgt/ELbpHmVqTt+ZreuIu
 +nP5HB9cjZCnC7Cvfx9CdY8c7kEdx7r0R0fVVhuLS2Wl50qjZqIfWWlbubifFz9rqisq
 qcxXFv9ln2tNzelTaAIHYnEoyHXwi4+5m8yk8EMC/8YQ+Q8GeAyqjLYt4NQMb4h0N97f
 hoF95xvRgTZpKgNF4BGKaeuQDDq5lxnX8MCA6TPZHsURpnSVbvHzPJzKgiDxCd8Rg29I
 huRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685589552; x=1688181552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FrfFhcpCDB+Tgl6xUiFVZLlSppgb/hsoX/FxVOIbZUk=;
 b=IShEJlKqwActMsoD25Uuj9Z6auHFwJa0xkEeDNAsCn0TqxFIoaYkW5u+GGsThX00ls
 VSv96mTVnljryZqaQylTjOXsNN3/ljmw/xempqdjVlXSsigSZ5Cvy+CKpgHudcOhtIRj
 FlXgvkL2XrmjGl8bkDCOJGam85cNNQ6wVjInzNuHGdsiZmfRer7UpPX+/YhDAtU5hQTx
 fW+ftPZaNRElTNP+xqCdZ12tjFGa8/HXQlFD5w+6nfhcFoVpvQaps4lJZa/OPJIQvhbe
 yWxaj1m2YIWckrx/5fYhFBP1IhJYCrTfx8Qp7g/e4OmSBBQSm6iRLiXgaLXrlYKZCyPC
 QjMQ==
X-Gm-Message-State: AC+VfDz66evwWQQH8ZTJC/w+0JkFj+6CQo1H7eS/En0jyZadFEwZfzAX
 Y0FOr/aWcpHebIKkEg1I5nyqNA==
X-Google-Smtp-Source: ACHHUZ4MZp29o+MFds/2GU+jNfvYE9Eyik8T0K+uVPXBV8iQEJ2uPuzNs2Z4+TUkzOA+GoV0RyHdvA==
X-Received: by 2002:a05:6a20:2326:b0:10b:bf3d:bc5d with SMTP id
 n38-20020a056a20232600b0010bbf3dbc5dmr4805679pzc.47.1685589552099; 
 Wed, 31 May 2023 20:19:12 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jd5-20020a170903260500b001a245b49731sm2146753plb.128.2023.05.31.20.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 20:19:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Mauro Matteo Cascella <mcascell@redhat.com>, P J P <pj.pandit@yahoo.co.in>,
 Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/2] net: Update MemReentrancyGuard for NIC
Date: Thu,  1 Jun 2023 12:18:57 +0900
Message-Id: <20230601031859.7115-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Recently MemReentrancyGuard was added to DeviceState to record that the
device is engaging in I/O. The network device backend needs to update it
when delivering a packet to a device.

This implementation follows what bottom half does, but it does not add
a tracepoint for the case that the network device backend started
delivering a packet to a device which is already engaging in I/O. This
is because such reentrancy frequently happens for
qemu_flush_queued_packets() and is insignificant.

This series consists of two patches. The first patch makes a bulk change to
add a new parameter to qemu_new_nic() and does not contain behavioral changes.
The second patch actually implements MemReentrancyGuard update.

V1 -> V2: Added the 'Fixes: CVE-2023-3019' tag

Akihiko Odaki (2):
  net: Provide MemReentrancyGuard * to qemu_new_nic()
  net: Update MemReentrancyGuard for NIC

 include/net/net.h             |  2 ++
 hw/net/allwinner-sun8i-emac.c |  3 ++-
 hw/net/allwinner_emac.c       |  3 ++-
 hw/net/cadence_gem.c          |  3 ++-
 hw/net/dp8393x.c              |  3 ++-
 hw/net/e1000.c                |  3 ++-
 hw/net/e1000e.c               |  2 +-
 hw/net/eepro100.c             |  4 +++-
 hw/net/etraxfs_eth.c          |  3 ++-
 hw/net/fsl_etsec/etsec.c      |  3 ++-
 hw/net/ftgmac100.c            |  3 ++-
 hw/net/i82596.c               |  2 +-
 hw/net/igb.c                  |  2 +-
 hw/net/imx_fec.c              |  2 +-
 hw/net/lan9118.c              |  3 ++-
 hw/net/mcf_fec.c              |  3 ++-
 hw/net/mipsnet.c              |  3 ++-
 hw/net/msf2-emac.c            |  3 ++-
 hw/net/mv88w8618_eth.c        |  3 ++-
 hw/net/ne2000-isa.c           |  3 ++-
 hw/net/ne2000-pci.c           |  3 ++-
 hw/net/npcm7xx_emc.c          |  3 ++-
 hw/net/opencores_eth.c        |  3 ++-
 hw/net/pcnet.c                |  3 ++-
 hw/net/rocker/rocker_fp.c     |  4 ++--
 hw/net/rtl8139.c              |  3 ++-
 hw/net/smc91c111.c            |  3 ++-
 hw/net/spapr_llan.c           |  3 ++-
 hw/net/stellaris_enet.c       |  3 ++-
 hw/net/sungem.c               |  2 +-
 hw/net/sunhme.c               |  3 ++-
 hw/net/tulip.c                |  3 ++-
 hw/net/virtio-net.c           |  6 ++++--
 hw/net/vmxnet3.c              |  2 +-
 hw/net/xen_nic.c              |  4 ++--
 hw/net/xgmac.c                |  3 ++-
 hw/net/xilinx_axienet.c       |  3 ++-
 hw/net/xilinx_ethlite.c       |  3 ++-
 hw/usb/dev-network.c          |  3 ++-
 net/net.c                     | 15 +++++++++++++++
 40 files changed, 90 insertions(+), 41 deletions(-)

-- 
2.40.1


