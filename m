Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1F76E321
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 10:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRThD-0005sd-T7; Thu, 03 Aug 2023 04:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRThB-0005rw-CO
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 04:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRTh9-0007q9-Ta
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 04:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691051310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gZxSudJPYbtRgl19NOy+MCJkSqqPqpxD3Ld6h48gfgM=;
 b=c4qWTEK4r44Ta6lKRQ+viWxWq9xlEY5LclzJR4sIGc9CWrTlB2R0TwZGj/R/qoYFiVOvif
 GNNYsbOi/Gb9h1cIWTC79Sggio3uciLs16jOnZo/O5wytE3uDH4I5JtOr8DM61FJf2hR5E
 Y7JOn8dxy0LRjDnpVjC1MGvtwoxkWNQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-5cFHXD-_NViHzn5HwtdslQ-1; Thu, 03 Aug 2023 04:28:29 -0400
X-MC-Unique: 5cFHXD-_NViHzn5HwtdslQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fe356c71d6so717001e87.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 01:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691051307; x=1691656107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gZxSudJPYbtRgl19NOy+MCJkSqqPqpxD3Ld6h48gfgM=;
 b=S9vVza+RceqVPDO6EJjS84Ykzjn4Wk3D/RzBDG8Suu9Ca7aDQaoG9jUtGJYUP/B2IJ
 +bEh/kYyc0cmlOWUR0+ceIkejQHKKbljIx6P3L+6xwN8Yn0lmb15d9lo54yTzUZykd4R
 8fHzifU/f2M6VamY7o6j0QM038aiHRZZ4mjdciFYtnzXeP1XRgqS5SrFG2LFxZMi2qbh
 Xu8EQZ5Pck/8/TVk35Jsoxwkz3FRARplMmFNRR9u7vGhOgzYhR8zTFyqEw/hwPeThR36
 aDcbgNHkcrsEucNS/Vhvdm7sJnK2OSIueud6jL6d2FMQCyGKmen69MRByiR4lW+e2pRf
 TeXA==
X-Gm-Message-State: ABy/qLYI6RUBzrIq4NpgN0p5fnCaQ+SLlrBk29i9TPPuppfzxvsbuB4a
 1SiQI2aJUxMOn0D4Dr7FapAz9vcPtJBeliIOU6WH1/tpgvP7EPm4lOFCfO/cTOaK7Lqorh4Wclk
 MsUj/ZmE5uvN8z8wENoqW1dVnV7/9Z8rGiD+h5mDKZmo5a2qvVhN43UY5MJVBm5g3m3o4RIUihk
 E=
X-Received: by 2002:ac2:504d:0:b0:4fe:82c:5c8a with SMTP id
 a13-20020ac2504d000000b004fe082c5c8amr5506244lfm.58.1691051307576; 
 Thu, 03 Aug 2023 01:28:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGcyAyjIaiuJKdLtbRMgEBj3eDY6p1kQPQxNnMm2UrQ3G/LXmrqFjx5hmMyI9hu3EeJqIBIwA==
X-Received: by 2002:ac2:504d:0:b0:4fe:82c:5c8a with SMTP id
 a13-20020ac2504d000000b004fe082c5c8amr5506221lfm.58.1691051307206; 
 Thu, 03 Aug 2023 01:28:27 -0700 (PDT)
Received: from step1.home (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 ci18-20020a170906c35200b0099bd682f317sm10090124ejb.206.2023.08.03.01.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 01:28:26 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 0/2] block/blkio: fix fd leak and add more comments for the
 fd passing
Date: Thu,  3 Aug 2023 10:28:23 +0200
Message-ID: <20230803082825.25293-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hanna discovered an fd leak in the error path, and a few comments to
improve in the code.

v2:
  - avoid to use `fd_supported` to track a valid fd [Hanna]

v1: https://lore.kernel.org/qemu-devel/20230801160332.122564-1-sgarzare@redhat.com/

Stefano Garzarella (2):
  block/blkio: close the fd when blkio_connect() fails
  block/blkio: add more comments on the fd passing handling

 block/blkio.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.41.0


