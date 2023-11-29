Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B968B7FD413
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 11:26:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Hl3-0003oP-UR; Wed, 29 Nov 2023 05:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r8Hkt-0003mW-Ny; Wed, 29 Nov 2023 05:25:20 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r8Hkm-000862-K1; Wed, 29 Nov 2023 05:25:16 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 67DDA60E8B;
 Wed, 29 Nov 2023 13:25:10 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:27::1:23] (unknown [2a02:6b8:b081:27::1:23])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vOSbJa01JOs0-oYiRVnH4; Wed, 29 Nov 2023 13:25:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1701253510;
 bh=GsCaT4jVEe7eBpXrJSXHDRRfDMlMATKroNHh4h1pVd0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XQfZ3mqQaIB4OiDAP1/yITkdco6wqbbr+DKzAEcIY+AgbMYpKxLTd5KV1SPXWTqcx
 WOFn8sP/ZwoVy2UEWEddYh03GiKTWELdXRY8l44jvhpdWVyOUgfTGg38skEXoxTafN
 Kl7UW4G2z2ZRgQx7XOoYFJQT/gG689Wo6/8hcxXw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <63ab9d13-4da2-4a81-b21e-e39a8ea4efe0@yandex-team.ru>
Date: Wed, 29 Nov 2023 13:25:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: commit: Allow users to request only format
 driver names in backing file format
Content-Language: en-US
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
References: <cover.1700837066.git.pkrempa@redhat.com>
 <8593619407b16a578896e1e9fcc77a18fe8d80fa.1700837066.git.pkrempa@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <8593619407b16a578896e1e9fcc77a18fe8d80fa.1700837066.git.pkrempa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24.11.23 17:52, Peter Krempa wrote:
> Introduce a new flag 'backing_file_format_no_protocol' for the
> block-commit QMP command which instructs the internals to use 'raw'
> instead of the protocol driver in case when a image is used without a
> dummy 'raw' wrapper.
> 
> The flag is designed such that it can be always asserted by management
> tools even when there isn't any update to backing files.
> 
> The flag will be used by libvirt so that the backing images still
> reference the proper format even when libvirt will stop using the dummy
> raw driver (raw driver with no other config). Libvirt needs this so that
> the images stay compatible with older libvirt versions which didn't
> expect that a protocol driver name can appear in the backing file format
> field.
> 
> Signed-off-by: Peter Krempa<pkrempa@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


