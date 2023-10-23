Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED77D371D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuJK-0006T5-SZ; Mon, 23 Oct 2023 08:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@emersion.fr>)
 id 1quplW-0007P0-JX
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 03:54:23 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@emersion.fr>)
 id 1quplU-0004Hu-1k
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 03:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1698047649; x=1698306849;
 bh=U0MZUFxkg3+UOPqNFrbWaEyCbKpVVLhO0H5Klvvg8Vk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=lL+VJACho1UvWH2TpvqzgGk2GEaCmjd2Cy0LlMg7A0/M9fARj929MAo2vaP+Dns2L
 UszlbpoHPjzn0iHan+IL6h7UGH5F4TREJFPUo7xUZaXQQZZ4RJdpQjPFCUDS3Jh3La
 R5dnRt2NqZGcxI4wYqOUm4U/e3Y1RH46n9DBDsJwtrclJko6uyb22CHp8VJe8BhPcb
 VbtRca/sGejOsaUxY5JbR4QMkuj2dq1XoNQZOdJR48hREt0o1VtyIoZ2XvJFwq1B2I
 uhY4vAHNp0YI10dWDi1eX6PdT2RcHpG7xoFcEn8IktqIO6XZPRirxYVSKk6pbQKb/P
 DSv4qJNVwfWtA==
Date: Mon, 23 Oct 2023 07:53:57 +0000
To: Albert Esteve <aesteve@redhat.com>
From: Simon Ser <contact@emersion.fr>
Cc: qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 iforbes@vmware.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Hans de Goede <hdegoede@redhat.com>, Matt Roper <matthew.d.roper@intel.com>,
 David Airlie <airlied@gmail.com>, banackm@vmware.com,
 Rob Clark <robdclark@gmail.com>, javierm@redhat.com, krastevm@vmware.com,
 spice-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mombasawalam@vmware.com, Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Gerd Hoffmann <kraxel@redhat.com>, stable@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Pekka Paalanen
 <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v6 1/9] drm: Disable the cursor plane on atomic contexts
 with virtualized drivers
Message-ID: <JK64byEJdVeFlotnfIzSsyiHWQCs-Luun_S8XqvJ4jG1In3fsBD6FBYZHcmKEvwDOas123VjhJoONJLALDRa5TCdA8avSMEN0xXA6oE8sVU=@emersion.fr>
In-Reply-To: <20231023074613.41327-2-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <20231023074613.41327-2-aesteve@redhat.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=contact@emersion.fr;
 helo=mail-4323.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Oct 2023 08:44:59 -0400
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

Acked-by: Simon Ser <contact@emersion.fr>

