Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A824582C8BE
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 02:29:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOSow-00068t-PO; Fri, 12 Jan 2024 20:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masscry@gmail.com>) id 1rOSos-00068d-JZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 20:28:19 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <masscry@gmail.com>) id 1rOSop-0007Ta-Sr
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 20:28:18 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e7b51b0ceso6864822e87.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 17:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705109292; x=1705714092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ePH5ad58Xt51TRUlT5QGzX+VzpOKc/4qm1BDXngGjvU=;
 b=SigkVb/o4tIizjnrTSD/NsTqe4QiKR3hp/GlMtICwfM3fJlV5Argx2gFjF9lHu72Wr
 GCOO8k2qIqYgCc3skh75WgxVme4EEVflVhHMp4U1esF/6H8tj6L0VZ0LIQV+W0OqFgXh
 +ooUzgxGStpybbErwTYvYx2PLkakVWe2BZmpw98pLqiV1ndDKjGpefq8SdXxX7Lx9YMt
 Bc02W40R22q4VtkaRwGCVQpy1vb7gsUp1UQzN772BSiHHWRmvtXNpin/ZqsIJyiv51Z2
 x9v2YKXxh0Dwdg3HW9B5F/IJVVvMKyef2TcMWQJym2x39pXrsnumWIExBRGiCVaQKPAf
 MEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705109292; x=1705714092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePH5ad58Xt51TRUlT5QGzX+VzpOKc/4qm1BDXngGjvU=;
 b=lIGYR0uh36qeFSJqVYyR6TvphmTWU495ZMC1iA72cfvqNqmtcKePrs/DqymoELYDFO
 QXgP7kwc9AAxKRMEKxpo4s/rg9VYhivS36fd5rdll05k01xthwA5gRylSY+/vdfz9obb
 X6ttMvYT592gQis0Jdo2ylbimYe9t/6ulmhFKpgRx4KEeU+r5K4VZStT79O2JBYp/Nvg
 9KODyLgRazSccgAyiSUqXZF9U/HFLx9F8JO4wDBmd7sw10v+cZ7rB4sK8NhzpS+opGQ9
 HEz2IMtGamaVhfPczvkzeeINmV724eRFaLy7A+DbLTySyzTCpg0owiqdTVXZB/G/GPW7
 KcPA==
X-Gm-Message-State: AOJu0YwT4JhHT0jrQv07KbM3DJRsHVkzZhPQwL1eFfJew1UtIBrpUUb8
 9CIlG6tfccxQzLBNb+izsyG5lKIgMGuYLjlehng=
X-Google-Smtp-Source: AGHT+IEcmGUGriyu68r5JQHuodEDQzTjT+LC045B19j8QbttgBK9kXrxWTHxLlQhW5GdS12Tv7RRIw==
X-Received: by 2002:a05:6512:10cb:b0:50e:bc4f:19d3 with SMTP id
 k11-20020a05651210cb00b0050ebc4f19d3mr1608432lfg.25.1705109291672; 
 Fri, 12 Jan 2024 17:28:11 -0800 (PST)
Received: from pc7.local (95-24-165-64.broadband.corbina.ru. [95.24.165.64])
 by smtp.gmail.com with ESMTPSA id
 d2-20020ac24c82000000b0050eab0f6a59sm669871lfl.84.2024.01.12.17.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 17:28:11 -0800 (PST)
From: Temir Zharaspayev <masscry@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>, Temir Zharaspayev <masscry@gmail.com>
Subject: [PATCH 0/2] Fix pointer arithmetic in indirect read for libvhost-user
 and libvduse
Date: Sat, 13 Jan 2024 04:27:39 +0300
Message-Id: <20240113012741.54664-1-masscry@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=masscry@gmail.com; helo=mail-lf1-x12b.google.com
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

Hello! I have found a problem with virtqueue_read_indirect_desc function, which
was advancing pointer to struct as it was a byte pointer, so every element
comming after first chunk would be copied somewhere out of buffer.

As I understand this is cold path, but nevertheless worth fixing.

Also, exacly same problem in vduse_queue_read_indirect_desc function, because
as I understand it is a copy of virtqueue_read_indirect_desc with vduse
backend.

I was not sure if element of scattered buffer may end in the middle of
vring_desc struct data, so instead of writing
desc += read_len/sizeof(struct vring_desc)
have implemented fix with proper byte pointer arithmetic.

Sincerely,
Temir.

Temir Zharaspayev (2):
  libvhost-user: Fix pointer arithmetic in indirect read
  libvduse: Fix pointer arithmetic in indirect read

 subprojects/libvduse/libvduse.c           | 11 ++++++-----
 subprojects/libvhost-user/libvhost-user.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.34.1


