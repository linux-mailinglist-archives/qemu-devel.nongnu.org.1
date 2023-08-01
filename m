Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CB676B844
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQr1v-0002ex-LW; Tue, 01 Aug 2023 11:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qQr1q-0002bo-OE
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:11:19 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qQr1n-0007Rd-Eb
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:11:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id BAFCE3200937;
 Tue,  1 Aug 2023 11:11:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 01 Aug 2023 11:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1690902671; x=1690989071; bh=k0
 kBnJdBdeuSbuOkx83gJpD1NNottLfGQHePi+BsV6w=; b=qF8BCji/2irReba/XP
 7Ng/1RRoEvCkrUFsdV/unqIXkRcF0VjPvizCp92RjcQUNDvsRIMd5AzQQ03yOkYi
 ZGACXq8c4ot/7L2b7cARadqw9N02W2js6yXOaO9KGWqF+2/zOrlK6lUgSJla1U99
 1VEvotDqmgkQOJ82/LNqE/plW44i3jQUP+B4y2U00chHr85HNi/wgMNqWX4kj6Xr
 fsexTtWXrsJ4yaU4vYdYOYvLte6V2wn6kHUH7Dx9L1ldc5i0gWBeQI1aqo6EEutC
 ruNWbN8Dyy2R0p21y/xUf2owxr1OCFZxeBBibGGQ8v5HEuK83C+/SnwZOBgoIM9R
 NxEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1690902671; x=1690989071; bh=k0kBnJdBdeuSb
 uOkx83gJpD1NNottLfGQHePi+BsV6w=; b=ngGWUu8t2cD8qGSjLsFpU7XOckL18
 ehM4zRbxe7VvOW0KzkW7tnlI8/AGacGmoZ7XvqxfFbhBWvRe2O0DsaDlaIcFnySq
 ipJPnkbKY+NlXMaUn8f2/SYdqmU205tWGy698qw3bGm9mNQJJabSSqKOZtt+cD2+
 BUV2/nCV6Yo/0ZA4X2EZ3lJib26/hiReZFEkSyhYIgT3iurvoqlehw9nuaMtrCEG
 qzK8S7A9PE+I0xlu5odyDZmwXFQmzINK0I6xw9v3WnV9FWf5Fu/sLXqc4hZzIMn+
 VYMDGqDTxC+NPFGdp+UqUGtKxMTVK8a2hjuZFiC2U70LKy4/I4hOh6Geg==
X-ME-Sender: <xms:jiDJZPQhOerKJ08UMoIltWIGGjrlUyvVwY6FdB8OClhzTC_k8XnrFg>
 <xme:jiDJZAzJujt9ikU8nQGpFxzAd5BXiC37hSxnb8SZECkxcPOEwpqIjxYwY9X1u0iGl
 CMvmGgDrFfx-bk2rA>
X-ME-Received: <xmr:jiDJZE26mPVBwv5HwUPj4CLd-ruTchCEQ9auc2jYaU9j3Y7tUYdqUVwyC1tJTa8H422KhdjOT34dFoF2Qyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdekfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufgjfhffkfggtgesghdtreertddttdenucfhrhhomheptehlhihsshgr
 ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepieduff
 euieelgfetgfdttddtkeekheekgfehkedufeevteegfeeiffetvdetueevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrg
 drihhs
X-ME-Proxy: <xmx:jiDJZPDsR5MnJjLiT16lfvvX76Ahlgor8h3uRUsnEj6PaVLdGF6jwA>
 <xmx:jiDJZIhGAx7elj2dg2EudUZggBAPTL_N6eu110klSE1gkGP0g9tb5w>
 <xmx:jiDJZDrUCS93npSuWCaJyDXW22Aysboi_k40s77bWPj73xxPVIlsJQ>
 <xmx:jyDJZEiu2Cu-VzgN1cOS7GVyvUndbstrFabgFICA_OJUUENcc0pi-w>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 11:11:10 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 2CD99756A; Tue,  1 Aug 2023 15:11:09 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com
Subject: Re: [PATCH v2 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
In-Reply-To: <20230801011723.627-7-gurchetansingh@chromium.org>
References: <20230801011723.627-1-gurchetansingh@chromium.org>
 <20230801011723.627-7-gurchetansingh@chromium.org>
Date: Tue, 01 Aug 2023 15:11:07 +0000
Message-ID: <873512bxx0.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=64.147.123.21; envelope-from=hi@alyssa.is;
 helo=wout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

--=-=-=
Content-Type: text/plain

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> +static int virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
> +{
> +    int result;
> +    uint64_t capset_mask;
> +    struct rutabaga_channels channels = { 0 };
> +    struct rutabaga_builder builder = { 0 };
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +    vr->rutabaga = NULL;
> +
> +    if (!vr->capset_names) {
> +        error_setg(errp, "a capset name from virtio-gpu spec");
> +        return -EINVAL;
> +    }
> +
> +    builder.wsi = RUTABAGA_WSI_SURFACELESS;
> +    /*
> +     * Currently, if WSI is specified, the only valid strings are "surfaceless"
> +     * or "headless".  Surfaceless doesn't create a native window surface, but
> +     * does copy from the render target to the Pixman buffer if a virtio-gpu
> +     * 2D hypercall is issued.  Surfacless is the default.
> +     *
> +     * Headless is like surfaceless, but doesn't copy to the Pixman buffer. The
> +     * use case is automated testing environments where there is no need to view
> +     * results.
> +     *
> +     * In the future, more performant virtio-gpu 2D UI integration may be added.
> +     */
> +    if (vr->wsi) {
> +        if (g_str_equal(vr->wsi, "surfaceless")) {
> +            vr->headless = false;
> +        } else if (g_str_equal(vr->wsi, "headless")) {
> +            vr->headless = true;
> +        } else {
> +            error_setg(errp, "invalid wsi option selected");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    result = rutabaga_calculate_capset_mask(vr->capset_names, &capset_mask);
> +    if (result) {
> +        error_setg(errp, "invalid capset names: %s", vr->capset_names);
> +        return result;
> +    }
> +
> +    builder.fence_cb = virtio_gpu_rutabaga_fence_cb;
> +    builder.debug_cb = virtio_gpu_rutabaga_debug_cb;
> +    builder.capset_mask = capset_mask;
> +
> +    /*
> +     * Using GPOINTER_TO_UINT(g) below causes segfaults.
> +     */
> +    builder.user_data =  (uint64_t)(uintptr_t *)(void *)g;
> +
> +    if (vr->wayland_socket_path) {
> +        if ((builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN)) == 0) {
> +            error_setg(errp, "cross-domain required with wayland socket");
> +            return -EINVAL;
> +        }
> +
> +        channels.channels = g_new0(struct rutabaga_channel, 1);
> +        channels.num_channels = 1;
> +        channels.channels[0].channel_name = vr->wayland_socket_path;
> +        channels.channels[0].channel_type = RUTABAGA_CHANNEL_TYPE_WAYLAND;
> +        builder.channels = &channels;
> +    }
> +

Would it be feasible to identify whether Wayland should be used in some
other way, to avoid users having to manually specify the socket path and
allow the standard wl_display_connect() logic to be used?

> +    result = rutabaga_init(&builder, &vr->rutabaga);
> +    if (builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN)) {
> +        g_free(channels.channels);
> +    }
> +
> +    return result;
> +}

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmTJIIsACgkQ+dvtSFmy
ccDAZg/8C41GDxWFErt2K4lU1J40O4SrSkZu1kwLYAMivMJsUrOmv5WYBZUBPtu4
2uaKeQCE0z3pIkt+Ki3MDAuMKQpnQZmX7yNbEBuCuDkIpu9NxYOqP5VOhFR6XvKY
m5Dt4jdrwtGCazqWDddhddgsamV34ZAPNqUOyVleh15p9Ant5gjRqqfOKA+3bPfM
TE1LxUzyQGKdczlmuwn0p2jJlMtLQE38EH9HaB+c02O1s75O3UcedOQwdxONZdu0
hlWDLJFI8a2xaiQheKNCX9ZCcKHlZcXy1u3l/Ba21FnyEXjrsmdZgfCwO9E4EsNh
N4qgZOsGc5I0tWMq3wCUrBDGp7AfL5qxpPFb+6hY//a8ByVRniQceXPz4pADDKbs
dARn2ip3eJcRlHLePCpBn2JK+vCBVBYOln92bchse8JYdzLiiCnsbOFcqXe8kzZ3
S1UDmMniYPhTZDVZ2jyhZDRKMqj1ozv5RsRifESqnc2DWBfz1zKvquarcHpve3+q
xUh6R5lXZ7VWPwanlOVOzy6JNm2GsDdgcpODXgTpPbuLBJa/dXMB3a6/EPyvpMQ4
NpEJtfkZqoIo/g6oC0D4dTsdWlzhtDWJfNPPapkY6W3OeHNwmXa89TbjSUj/fGIE
ZtY/uTOcbjxWx/ut5paCrpL3ExmC5+AiXMlfHIc5gZQVKM3y3ds=
=EG+K
-----END PGP SIGNATURE-----
--=-=-=--

