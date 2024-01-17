Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3C83065D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ5US-0001jf-K3; Wed, 17 Jan 2024 07:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ54g-0007GB-Jr
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:31:18 -0500
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ54e-00009E-NN
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:31:17 -0500
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7bef44df5c6so193922039f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705494675; x=1706099475; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yiqFhkQmfBD4mJONsjk8Qfil7m9Q+Gx5+05v5IpbGtU=;
 b=Tg1qr7k3KKV39Mp4m66F6yUdPDsURUvvDQ4pYt8QtL8CGhWxFcFo7LohgVzA2xu4Z5
 7gE6eF7vaGX05tcSoJBhYkYYDcxMTpZrTZ4o7zis7gVQtskrKJ3gBCyzkkcYO0uOgM7+
 MT1z9BInnEyvts9TQfk/hDla7pydKS3ucVsOtWlBa2/L69WoDY4aDkJsG5FxlcYiSAyx
 iKdpylVHLprnsaq4S86LE1QvHzbjylngbGLEMiHsJo2o0+hHXw6NxTe89KwGvvhFnj9k
 YTZZyqsGQ5BFQ0y3q9TcwtDsPhDshj0tuINe5lw5pYPZpNHbN/Yt1W/AgI0FDmevxEWj
 Cf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705494675; x=1706099475;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yiqFhkQmfBD4mJONsjk8Qfil7m9Q+Gx5+05v5IpbGtU=;
 b=TtSNuqAJnJQn0mRYAj6yxPSAXwyefT4Jz1EoGc8HAnE4y+/fAuufWSZbB+nbkSDjlR
 7V26ygny97nsPP9hgvMbEgHO6kzz3VJ5fHy1DJKj50lhJjT+qs0BpmGSZKvGhT0b47GR
 jtikmtQwS1+j9O0lsYz6+S0rsM0JMJukkIJBAX58SZgS3SeYxyfNnjLXpY849k5QYkqh
 do1TYdGg4luSVuyECbawbtXxPMF1T98m9QSlKuhPKyazm+pHcHEDRYST9H2hRsuOsrzq
 zDpLaBtauLj1aL0a1ANiaUghhm03VMRXsQ1y8W2F7U+1XJjRWnGeN21qqj+NTfDqvKZ0
 Dltg==
X-Gm-Message-State: AOJu0YxBW5qG2+b78jMvZhhHiCkl8CdCxlP88KTe/KBdgNohtm8gsrom
 Q+RGwTXTySd1ils0sNRGuWpRPs+mvmPuv8dEJ/NDV6zRZRk=
X-Google-Smtp-Source: AGHT+IF0tAsL7lNOPqe8+OxUfdbBfTfARQ4phzj+EzP7xB8JFCfHiQm/RDp1XC4kjd/4Z27JmqA3dP3IkBBkWPUdADg=
X-Received: by 2002:a05:6e02:110f:b0:361:93d2:69a4 with SMTP id
 u15-20020a056e02110f00b0036193d269a4mr416346ilk.11.1705494675417; Wed, 17 Jan
 2024 04:31:15 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 13:31:11 +0100
Message-ID: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
Subject: [PATCH 2/4] Avoid multiple definitions of copy_file_range
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=manolodemedici@gmail.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jan 2024 07:57:54 -0500
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

It's already defined as a stub on the GNU Hurd.

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..05426abb7d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1999,7 +1999,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
     return handle_aiocb_write_zeroes(aiocb);
 }

-#ifndef HAVE_COPY_FILE_RANGE
+#if !defined(HAVE_COPY_FILE_RANGE) && !defined(__GNU__)
 static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
                              off_t *out_off, size_t len, unsigned int flags)
 {
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..05426abb7d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1999,7 +1999,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
     return handle_aiocb_write_zeroes(aiocb);
 }

-#ifndef HAVE_COPY_FILE_RANGE
+#if !defined(HAVE_COPY_FILE_RANGE) && !defined(__GNU__)
 static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
                              off_t *out_off, size_t len, unsigned int flags)
 {
--
2.43.0

