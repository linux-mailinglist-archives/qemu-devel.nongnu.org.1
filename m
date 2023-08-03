Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146B76F091
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 19:26:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRc4V-0007Nw-R8; Thu, 03 Aug 2023 13:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qRc4T-0007Mz-Vz
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 13:25:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qRc4R-0003tU-W5
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 13:25:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31765792c7cso1113904f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691083504; x=1691688304;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Px0+HSG7M6lRLouq1rKBHmkgjnntHIwpVNsUQFwfEuY=;
 b=QzTS1AOTvKp3t6hIdhah6O2cHoR14g+ap+lvQlhyq+MRE549gZ0jj7lblFFCTvcJN4
 w2TUFPTPzzfXtbJNbWDbaBEKBOs/mkMT6haj/jbHfPL0W2ofPDDivF77bXCyoZFy5Cy2
 c8gY655qu1nM+zVXYpc2UpF+JkhE05zG2A7LKeaXbmkVp54u8bt/stcO5Xq61w58JQ2x
 xrW9SRzl2BCPz3lv2LQt6STvueZFDX2+D9NfrrTP76lm/ctTKdaTJp9qgvXRZNlVEE1O
 3DpEQOdCXTCzedZFt1nBDyhdLrW13vwPn47YRFBRNM0cs9L/JMO9mTEXu/QaPfzz8rVZ
 poCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691083504; x=1691688304;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Px0+HSG7M6lRLouq1rKBHmkgjnntHIwpVNsUQFwfEuY=;
 b=ioAGdHv/ZI3dEJkBaEeaK3RCohKqhq5Pzimya66LUEE6paVy1S0Ztt1oEkA7cKvh4r
 Ggl+CrD1iLrsywh0YsF8wNbjWTAMm0GbJNXEJXenEG+E/YhspWJWm9zvjmmEV9I8Vvb5
 /Y/nkUl1s5WJfhywKSHiiv6dRoK3YaiVcD00it6VQus29eP390ZPvNYTKXgOiMhwmRJi
 j8qbAMSOLoVdCsLyrXFxOBTme3XAvG8eVrsu2yd4aQEqiiCzfZf2nS8QvU6acNJs01UP
 YmrhaDl0pKed0GiTNehJjtiC721cLrsZv5YyaNWobdIzrb2BLkJb9KZZLZ9l+bplZ5p+
 78vw==
X-Gm-Message-State: ABy/qLZbzE79T+5oaYKR+iLuZGlXbdfz+SkCbFXngtIGfsffmJlzcGwa
 8zlOn0PLYJJ8tcxo4gJ7CnWGo5n/VjReBXe0j9Whng==
X-Google-Smtp-Source: APBJJlG5oze8YAvCvxnJl/ldaymO5YHPrn4abeLPot0H/pe7BpOg46Qhyd1eL4bJZLrPlify6ENl2w==
X-Received: by 2002:a05:6000:109:b0:314:4a15:e557 with SMTP id
 o9-20020a056000010900b003144a15e557mr8204614wrx.5.1691083504624; 
 Thu, 03 Aug 2023 10:25:04 -0700 (PDT)
Received: from meli.delivery (75.53-176-91.adsl-dyn.isp.belgacom.be.
 [91.176.53.75]) by smtp.gmail.com with ESMTPSA id
 e3-20020a5d5943000000b00317ac0642b0sm372669wri.27.2023.08.03.10.25.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Aug 2023 10:25:04 -0700 (PDT)
Date: Thu, 03 Aug 2023 19:40:46 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Jonah Palmer <jonah.palmer@oracle.com>
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org, viresh.kumar@linaro.org,
 armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH v3 1/3] qmp: remove virtio_list, search QOM tree instead
User-Agent: meli 0.7.3
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
 <20230803145500.2108691-2-jonah.palmer@oracle.com>
In-Reply-To: <20230803145500.2108691-2-jonah.palmer@oracle.com>
Message-ID: <ytsdr.hu96pu2zioj@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 03 Aug 2023 17:54, Jonah Palmer <jonah.palmer@oracle.com> wrote:
>-VirtioInfoList *qmp_x_query_virtio(Error **errp)
>+static int query_dev_child(Object *child, void *opaque)
> {
>-    VirtioInfoList *list = NULL;
>-    VirtioInfo *node;
>-    VirtIODevice *vdev;
>+    VirtioInfoList **vdevs = opaque;
>+    Object *dev = object_dynamic_cast(child, TYPE_VIRTIO_DEVICE);
>+    if (dev != NULL && DEVICE(dev)->realized) {
>+        VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>+
>+        VirtioInfo *info = g_new(VirtioInfo, 1);
>+
>+        /* Get canonical path of device */
>+        gchar *path = object_get_canonical_path(dev);

(You can use g_autofree char * here)

>+
>+        info->path = g_strdup(path);
>+        info->name = g_strdup(vdev->name);
>+        QAPI_LIST_PREPEND(*vdevs, info);
> 
>-    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>-        DeviceState *dev = DEVICE(vdev);
>-        Error *err = NULL;
>-        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>-
>-        if (err == NULL) {
>-            GString *is_realized = qobject_to_json_pretty(obj, true);
>-            /* virtio device is NOT realized, remove it from list */
>-            if (!strncmp(is_realized->str, "false", 4)) {
>-                QTAILQ_REMOVE(&virtio_list, vdev, next);
>-            } else {
>-                node = g_new(VirtioInfo, 1);
>-                node->path = g_strdup(dev->canonical_path);
>-                node->name = g_strdup(vdev->name);
>-                QAPI_LIST_PREPEND(list, node);
>-            }
>-           g_string_free(is_realized, true);
>-        }
>-        qobject_unref(obj);
>+        g_free(path);
>+    } else {
>+        object_unref(dev);
>     }

The object_unref should not happen only in the else branch, no? Though 
it's not clear to me where the ref count was previously incremented.

>+    object_child_foreach_recursive(object_get_root(), query_dev_child, 
>&vdevs);
>+    if (vdevs == NULL) {
>+        error_setg(errp, "No virtio devices found");
>+        return NULL;

(No need for early return here)

>     }
>-    return NULL;
>+    return vdevs;
>+}
>+
>+VirtIODevice *qmp_find_virtio_device(const char *path)
>+{
>+    /* Verify the canonical path is a realized virtio device */
>+    Object *dev = object_dynamic_cast(object_resolve_path(path, NULL),
>+                                      TYPE_VIRTIO_DEVICE);
>+    if (!dev || !DEVICE(dev)->realized) {
>+        object_unref(dev);

Same as before with object refs

