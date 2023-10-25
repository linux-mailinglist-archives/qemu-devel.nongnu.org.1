Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1347D6877
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 12:28:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvb7A-0000nS-9b; Wed, 25 Oct 2023 06:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvb75-0000iA-CR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvb72-0004Xq-WF
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698229664;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfUhYSK1hn2dpRipPUNq/idVgp43Wp+e6ZcoNkKzlxk=;
 b=fOZQDb0sYTsqGtRQHXDnfyxvFCpn7VZGsTxt0UT7linaIyT3Cj3Nm+Iup8hvSJ+FyWR0sz
 2CXdUYPWtFtdl7Mj2Hf8z0z0I7/xJQw7s7oWkfNnYCZWpwLdLw4Mu5khdgyV5/jzcfGGvS
 cvsHp+BdwuRjTtg+LMQhkqOgum4xpjs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-v_UinhpOMqyPQhYopQEgYQ-1; Wed, 25 Oct 2023 06:27:42 -0400
X-MC-Unique: v_UinhpOMqyPQhYopQEgYQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so33863555e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 03:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698229661; x=1698834461;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfUhYSK1hn2dpRipPUNq/idVgp43Wp+e6ZcoNkKzlxk=;
 b=E3D46Hxya2/d4WJfzdSOCnHRA9jJnFHuFL/yALy5QgqsSWQ8MUI1M6Gt8MV5eQbM08
 wD/PxAwG62+BYFh0HzXbjDMLI76F36DsjM23r0/QjLItSmfw3DnYAFgm6BRvKSqa41/J
 d8CcgXsRoHNPHRumk4G9hB3b4Wrkr5+jhFnjHyY17x6baWm3w1N/9BGL5nXeutJpgslO
 bQa6mvG+zwzPs5sWBda91RrYmanAP3yxTFL70s+TSMF82jo1+d4uEexPOIzgKMzTgiXX
 KJXMz4nhT8h1ilM/BvfYCVpCLVzQN2IKTooPpSmsx4bN8F8LTyTuogtqjl4l/OTg+dj7
 yvCA==
X-Gm-Message-State: AOJu0YwG8GCdE6hVcaA7Gw/pv+CQwL7W+AYwL6LCZ3xFhYGcJ5SpbuUP
 dCLGpjlH600YZBFPhQ5oqBi8oxgc5R7al7VX7SX15oHUPuidgdLFfyVSzXKcKYPaCOqceUOwrXT
 LgtBgUiYTSnGhFKs=
X-Received: by 2002:a05:600c:46d1:b0:407:8f23:cf3 with SMTP id
 q17-20020a05600c46d100b004078f230cf3mr10499546wmo.26.1698229661804; 
 Wed, 25 Oct 2023 03:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEveailLYgM1sYQTmLmMy9b7GGZh+gUgkSXtUCmyAaa8O7cgZhFH6IaJ3ioAzIf3LHdESG1gA==
X-Received: by 2002:a05:600c:46d1:b0:407:8f23:cf3 with SMTP id
 q17-20020a05600c46d100b004078f230cf3mr10499522wmo.26.1698229661381; 
 Wed, 25 Oct 2023 03:27:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c11cd00b0040770ec2c19sm18937051wmi.10.2023.10.25.03.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 03:27:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  "Denis V
 . Lunev" <den@openvz.org>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Stefan Weil <sw@weilnetz.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  "Maciej S . Szmigiero"
 <maciej.szmigiero@oracle.com>,  Fam Zheng <fam@euphon.net>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 1/2] util/uuid: Add UUID_STR_LEN definition
In-Reply-To: <20231025101245.751559-2-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Wed, 25 Oct 2023 12:12:44 +0200")
References: <20231025101245.751559-1-clg@redhat.com>
 <20231025101245.751559-2-clg@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 25 Oct 2023 12:27:40 +0200
Message-ID: <874jiff143.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> qemu_uuid_unparse() includes a trailing NUL when writing the uuid
> string and the buffer size should be UUID_FMT_LEN + 1 bytes. Add a
> define for this size and use it where required.
>
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/qemu/uuid.h              | 1 +
>  block/parallels-ext.c            | 2 +-
>  block/vdi.c                      | 2 +-
>  hw/core/qdev-properties-system.c | 2 +-
>  hw/hyperv/vmbus.c                | 4 ++--
>  migration/savevm.c               | 4 ++--
>  tests/unit/test-uuid.c           | 2 +-
>  util/uuid.c                      | 2 +-
>  8 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h

Reviewed-by: Juan Quintela <quintela@redhat.com>


