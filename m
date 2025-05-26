Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FAAC422A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 May 2025 17:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZW4-0006VV-2y; Mon, 26 May 2025 11:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uJZVx-0006Rx-B0
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:13:22 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uJZVu-0004Hj-VB
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:13:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748272382; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EWgtv2uHUaNNAMXt+UkhqGrGMIu+eLK2TJqEWgGMxvpItZ+5wiRQ4/YhFrn4PVpy6xAFfdp3uzg/QVeNF7+et5cwwiyYZH3WibD9sKRTfwjp/VyOweTpn1JIrhpF58GJbzYfXowCDTRV+/XxkBsqT8EDyI76A2W+/dZhYyLohUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748272382;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LI0e/9piBW8ByilusaAwOcrkf++YeTuom/SuKOX0BvY=; 
 b=cvmgbXFHecxYLGcWuQs9I4hQK1jkLE8IcC9sJmAhDoquPQV8/Fyxe4Uf4KOFUcXh/wIL+r50lvTwJJLGY5hd1ffpbq1yMzMiibFydiAtjaCn6XiqqAZgCFHQ/tXX771n3GuOObfnqkgojFCZ/TxRcypMZUMZR1N8zyoizXTK7ac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748272382; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=LI0e/9piBW8ByilusaAwOcrkf++YeTuom/SuKOX0BvY=;
 b=TOS4eNZNrJ2BjUV4LYlWGx/v2EHTnDeb4ECW+AnB1UVoBMiI7roY4ouqRYiHlRRF
 GUxNkbr1mC2eXdrSr+uWTgwGtet9l30mRiYtffbZkT2z33BrhZdBTp5A0Fn8KSmd0qF
 W6HyspIezpSDhh3NbllWcwALF2LKhepPWp6M6tx4=
Received: by mx.zohomail.com with SMTPS id 1748272380570776.3727868299383;
 Mon, 26 May 2025 08:13:00 -0700 (PDT)
Message-ID: <78a0685c-e28d-4960-a3a8-d1c5c68ddaed@collabora.com>
Date: Mon, 26 May 2025 18:12:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250523233305.433424-1-dmitry.osipenko@collabora.com>
 <20250523233305.433424-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250523233305.433424-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 5/24/25 02:33, Dmitry Osipenko wrote:
> +  * - Asahi DRM native context
> +    - `Downstream version`_ of Asahi Linux kernel
> +    - `mr1274`_
> +
> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
> +.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274

Asahi opened new MR couple weeks ago. Forgot to update the doc link,
will correct in v13.

-- 
Best regards,
Dmitry

