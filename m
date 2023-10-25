Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07947D6879
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 12:28:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvb7c-0001lg-6B; Wed, 25 Oct 2023 06:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvb7Z-0001aK-Cf
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvb7V-0004ak-TN
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698229691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUliLORN2b1KdbpstSv2FcQCMdc1uQLhaESj56Hf1Cg=;
 b=QX2KukUETJAeEk6+p50IjUB99EOfJ0FUtGDwTgBYPP5o4upRVxyShPzGE+UKHCwniY12bM
 UYeiSlbrDAusb6Ge3J1cKNvfiaoSkmKLrKEaENHDq7aAXsud9oNczzV0ztb3uO3Re02tWH
 D45dNQUyyMwWkuGVDzbRwObztvTjjS4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-TlY0xL5IPc6QuLItk3ZfWw-1; Wed, 25 Oct 2023 06:28:10 -0400
X-MC-Unique: TlY0xL5IPc6QuLItk3ZfWw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32da87eac93so2317436f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 03:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698229689; x=1698834489;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tUliLORN2b1KdbpstSv2FcQCMdc1uQLhaESj56Hf1Cg=;
 b=scCeK4xQuKcLC+k1v647R81LSixf7RNISAiV3yOQIHLv8Q1dSN26r7eRqQirEyz5Z4
 bFwe7YfizLAhxhQZM2QtV3NnkcYsQM6CKtZrpmeTq8ZEML1sKxm0qvK2QOsi3lAnupIo
 U9VmHDsYxrnbJ57GgqOJtZD9TdNiXaYMxKX7w52l5K2qepVhbU3dAffpJlVSKFISYE+X
 h8RwdpfC4U+XtLfD/wWcvHYpZ1+Ih11dwIGYQchC/Wc+i4FMLXYNjR6OJNyDDRtcl8SQ
 H8wkRW0VweuWgCCTCZRyD4fyMYGxh5yJNP9gCGdtryUfx4ah/o3kc5NgMDccm0YactPh
 p/AA==
X-Gm-Message-State: AOJu0YwHlP+sYo9bXAlNvKRWN0zRqejjsDEvSL1ruRUhPrCpIDtweM5M
 ZMQZfFMZnBagdOBP0xnZXJATNFT3wf+ZJTTXILTgMCzQpbIEutwyvMOK1PH0yEvpk7vjsNRymlQ
 6qkOCXAXU6aysUuA=
X-Received: by 2002:adf:e10a:0:b0:32d:9787:53bc with SMTP id
 t10-20020adfe10a000000b0032d978753bcmr9659050wrz.62.1698229689081; 
 Wed, 25 Oct 2023 03:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSwMrGXJfpFO7tBKDM89+oUibgH5GBKesv7vQIV3bKpke3vffd+CBhtG1G5y0woudjx0Sr3g==
X-Received: by 2002:adf:e10a:0:b0:32d:9787:53bc with SMTP id
 t10-20020adfe10a000000b0032d978753bcmr9659037wrz.62.1698229688770; 
 Wed, 25 Oct 2023 03:28:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k17-20020a5d4291000000b0032da87e32e2sm11883383wrq.4.2023.10.25.03.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 03:28:08 -0700 (PDT)
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
 <leobras@redhat.com>,  Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] vfio/pci: Fix buffer overrun when writing the VF token
In-Reply-To: <20231025101245.751559-3-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Wed, 25 Oct 2023 12:12:45 +0200")
References: <20231025101245.751559-1-clg@redhat.com>
 <20231025101245.751559-3-clg@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 25 Oct 2023 12:28:07 +0200
Message-ID: <87zg07dmiw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> string and the buffer size should be UUID_FMT_LEN + 1 bytes. Use the
> recently added UUID_STR_LEN which defines the correct size.
>
> Fixes: CID 1522913
> Fixes: 2dca1b37a760 ("vfio/pci: add support for VF token")
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

For what is worth O:-)


