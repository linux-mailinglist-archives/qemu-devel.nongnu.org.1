Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD809707DEB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:19:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaiQ-0007ua-NP; Thu, 18 May 2023 06:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiL-0007la-TN
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiK-0004nH-Ev
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=03shp6p8Z50ZS0/93a7dqo7ioIjlNcG0U1jydKMSXo0=;
 b=GHnxIGcr3hgYprSjC2wTG5VVb8gUixEUMWvoJ9kVTyQZc/1pzP2iLakKqMy9aAzmXbrdhS
 9U2zM2d21wzoK2eD0mpZrHAyQl21bxB6Uxm/wT5mWVZS64/bVz2epr9KqqAasuj0dERyWK
 qegMUDbwkeboYDm7IxkZGnGrOX5euy4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-OjgXfb8ZM9SM7W5oX1iklg-1; Thu, 18 May 2023 06:18:26 -0400
X-MC-Unique: OjgXfb8ZM9SM7W5oX1iklg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-50bcd245040so2455733a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405105; x=1686997105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03shp6p8Z50ZS0/93a7dqo7ioIjlNcG0U1jydKMSXo0=;
 b=jEhzjaT+sQjIdrbyX73NXJQ45SOR86o2oZ3UoZRVmpZpjSKzSPOyXE4rSjvoZnGfNJ
 V70jlqqf48CGwW/KARm5biAYklTSYFE+Ccmlw8ZFda6tWOQAqgOLrimNfHju1KTGdl9n
 TLKFHXUiWwZnRm1kmhC8aOU7oePHNTgySAmkDOYDbRZBfZaD3ThFdEZwhxhIjFN0DISd
 AaTOGdGN5x7E3k5YyOJPmYFN/F+xkcW+SoMYjcfXw0X3HYVHEPscOPAyStMwLEJnvkwS
 CKfu/N+ZqXINV1ZzEOSCBZaN7QUIaDaMb6iYkMTr6ReC87+2XFcd0afOl5MSYLqcdQhu
 U8Fw==
X-Gm-Message-State: AC+VfDy2nUAZJS1uBHhvNz/z/2I87qo/9fgfASFU5GwXntq8dpTmj+6d
 GDSqzFlVo6GO+tYv3c1gVmdZMINTWrXUTAKlrtYFN+6E0P3LMQ0HxBtPqaPQGSYaW8tE5Y5FS4h
 TjzsxwyFthKBCUT24l5iBGGEDgY2L9lCQ5xlP2gJKOEScI8BXel0ebJGBPoe44x9j6eYCzhHa9R
 E=
X-Received: by 2002:a50:ee1a:0:b0:50c:160d:f652 with SMTP id
 g26-20020a50ee1a000000b0050c160df652mr4689761eds.8.1684405105270; 
 Thu, 18 May 2023 03:18:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zHiQPZkPYBaPFm49xTjlsGiArZqzeDB6WRY2Ls0HS8x8lOq+MEEW5Sn50gk+UNy3DUnrjgg==
X-Received: by 2002:a50:ee1a:0:b0:50c:160d:f652 with SMTP id
 g26-20020a50ee1a000000b0050c160df652mr4689749eds.8.1684405105056; 
 Thu, 18 May 2023 03:18:25 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a50ef0b000000b005067d6b06efsm410276eds.17.2023.05.18.03.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 0/5] qmp: cleanup QMP dispatcher coroutine
Date: Thu, 18 May 2023 12:18:18 +0200
Message-Id: <20230518101823.992158-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

The QMP dispatcher coroutine is a bit messy.  Clean it up by creating
small and understandable functions, and once the wakeup logic is clear
change it to remove the qatomic_mb_read()/qatomic_mb_set() pair.

With this change and the other HMP series posted, the last use of
qatomic_mb_read() is removed.

Paolo

Paolo Bonzini (5):
  monitor: cleanup detection of qmp_dispatcher_co shutting down
  monitor: cleanup fetching of QMP requests
  monitor: introduce qmp_dispatcher_co_wake
  monitor: extract request dequeuing to a new function
  monitor: do not use mb_read/mb_set

 monitor/monitor-internal.h |   2 +-
 monitor/monitor.c          |  33 +++--------
 monitor/qmp.c              | 110 ++++++++++++++++++++++++-------------
 3 files changed, 80 insertions(+), 65 deletions(-)

-- 
2.40.1


