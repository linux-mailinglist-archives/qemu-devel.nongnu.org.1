Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CCA29AB2
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Feb 2025 21:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tflhK-0005El-Oj; Wed, 05 Feb 2025 15:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tflhI-0005Ed-CE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:08:32 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tflhG-0001dw-FX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:08:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738786093; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j48lG7OuTeb/n2gZZaOeXpu3tQFaKNJvmSMCS0ahHgkCIB53DVyGPJEsZdf+9016SlV3Lh5qkJkF5CBXQwQ0xKN0HGG6xhYKbIAicF5h20R+tUD385VONniRXPMMbkoE5P6jjC00YmHLT2YWrtUbhAjE/QHhBkz9dN3iLdB9iQk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738786093;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Oxpa9QqI016jNflBym9USoEhlSxOEJUbtVOVpqvSJtM=; 
 b=nsWxGo7uZbh3jA7ckpB+Snc312iR48moyRQlDapbt5TVKH1OWQPqpUGIie8LM+poRjFjwZGb4Xx9JBm1ctXXjMjd5EsWps7n7ENJFacDr5HQSjuJLPjqyuX1W3jtG2nO91T/qjAb6zOZL7D7eXUVufHbOvNKqLZu1VRz2ZhUKHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738786093; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Oxpa9QqI016jNflBym9USoEhlSxOEJUbtVOVpqvSJtM=;
 b=Ee8HqoVTKPImWAa2xxuv5fNT55wJUNIHrclqJMwFyCRwJ8tiNsmxIGMXU5Wh2lKd
 0p0axn9MDxem69bVE0kQMlda/XWmlp1rPJZuXBilBRG9daE5IY2aaOd7jEAqLmaP//P
 utAyTG+PQV+BlLHK5eP+YL2DBu7i1bMktaraAmQs=
Received: by mx.zohomail.com with SMTPS id 1738786090024514.4967380560064;
 Wed, 5 Feb 2025 12:08:10 -0800 (PST)
Message-ID: <4250091a-d823-4bcc-89ce-80f3f26f3be4@collabora.com>
Date: Wed, 5 Feb 2025 23:08:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
To: "Kim, Dongwon" <dongwon.kim@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Pau_Monn=C3=A9=2C_Roger?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
 <87ikprflbb.fsf@draig.linaro.org>
 <PH8PR11MB6879D81CAA931B0718DF3B1EFAF52@PH8PR11MB6879.namprd11.prod.outlook.com>
 <878qqmbzb9.fsf@draig.linaro.org>
 <SA1PR11MB6870F6C4479128EA3CBF9543FAF42@SA1PR11MB6870.namprd11.prod.outlook.com>
 <63a991d6-dfb5-4a7d-80d0-4c31673d3251@collabora.com>
 <PH8PR11MB687958C8B4F275CA4D9BD614FAF72@PH8PR11MB6879.namprd11.prod.outlook.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <PH8PR11MB687958C8B4F275CA4D9BD614FAF72@PH8PR11MB6879.namprd11.prod.outlook.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/5/25 21:53, Kim, Dongwon wrote:
> Thanks for showing me the video. I will take a look and check what would go wrong here. I kinda understand corruption may happen
> in some scenario but I don't know what could cause the upside down image. Do you have any idea?? Maybe the frame was temporarily replaced with
> a mishandled texture that QEMU creates from the surface temporarily but I am not sure..

No clue. Could be anything. Could be a GTK/Wayland bug, could be an
obscure QEMU bug. GTK expert wanted here.

> In the worst case scenario, I think we may have to revert the change from gtk-gl-area.c for now until the problem is root-caused.

Good to me

> But you would see some rendering timeout in case the GTK window is in invisible state (like minimization).

No timeouts observed

-- 
Best regards,
Dmitry

