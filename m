Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE3D76B951
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 18:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrqm-0001hw-6P; Tue, 01 Aug 2023 12:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qQrqZ-0001M9-K8
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qQrqX-00058T-Sb
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690905818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JZ4ln6QmFhRPxErC+TTe4SZh5HhTL1V8Bih6Vi78QkQ=;
 b=ZeL6XQqux4zr2Q8p3K4UgN1h33644bBAwhe4yaKGxiQyfANghBVGBX+Qz+Rx5f0hKOr98o
 Ra7aEywQw3C3Y+gnFHsRIkvYmjXaI/09vQfzSt6SD0Uj5zMHizWZlqsYtgLs2QceXxpK0a
 ovEzwxJGoQ6yXtOJ2ESnMqSqZMFvmnI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-dTRcA7TSNTG9Rhn1eFlUSQ-1; Tue, 01 Aug 2023 12:03:37 -0400
X-MC-Unique: dTRcA7TSNTG9Rhn1eFlUSQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so3235529f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 09:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690905815; x=1691510615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JZ4ln6QmFhRPxErC+TTe4SZh5HhTL1V8Bih6Vi78QkQ=;
 b=FcErYyEFGJXQTKzsjHc4TGleyj9uA+iqlLteDVHcp8SCVuw21SJcIVLrRR42I3UFcT
 vtyRKvU2AeThwz7b5phcp3HZIk6nHwFhJ9zOpmP2Jok6Fgr78eq2FOJsXSBOOpadjx1T
 pQn5lmUnDfKeYBy6eg8Yr8aJcIGs8+eZg66ZZcafQby2oczIFCTGFpliAMcfahzGknM9
 gE+nvrVxznqL6fCd2aiUm2T4Y0tmC/wvklaYQffdkS28msTiQt0AzfuNppm8HZIbOg2G
 XkPrnLkXXxvbQzeU2ZDuxxkMhnmlXTUUXX42aRA4K+m+reZEQe2whKFUvgaSivX/7TLg
 dcYw==
X-Gm-Message-State: ABy/qLYOkeiBCIdFM+MPa+wKPHo8TP92PHNOjKbbjgOjymYusd657okG
 UNNacxrGsrNOZDeBKWF6qYXbpBwO68JejOYC/0F5G09yQgt/ioN9UAp9ky3MfJ05iXqe9CSD9w6
 3QEK9EiczakBmnuD1BIreW0VmV3lCyIKiaEeFBMiWW0mM4VUy+Xsv4ZV7rWPUJf64pqyymG+YKi
 s=
X-Received: by 2002:adf:dd50:0:b0:315:963a:4a3e with SMTP id
 u16-20020adfdd50000000b00315963a4a3emr2564439wrm.7.1690905815651; 
 Tue, 01 Aug 2023 09:03:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6ItGb0KMpgtYDXG4mpWjchqmSweQlv9vHvRgOvCtQhf3mTpjwj25QPO3gcWcJZStgwme4oQ==
X-Received: by 2002:adf:dd50:0:b0:315:963a:4a3e with SMTP id
 u16-20020adfdd50000000b00315963a4a3emr2564418wrm.7.1690905815266; 
 Tue, 01 Aug 2023 09:03:35 -0700 (PDT)
Received: from step1.. (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 o12-20020adfcf0c000000b00301a351a8d6sm16427813wrj.84.2023.08.01.09.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 09:03:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/2] block/blkio: fix fd leak and add more comments for the fd
 passing
Date: Tue,  1 Aug 2023 18:03:30 +0200
Message-ID: <20230801160332.122564-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Stefano Garzarella (2):
  block/blkio: close the fd when blkio_connect() fails
  block/blkio: add more comments on the fd passing handling

 block/blkio.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

-- 
2.41.0


