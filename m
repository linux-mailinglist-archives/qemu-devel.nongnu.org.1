Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06AA885A1
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Apr 2025 16:48:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4L6L-0006kt-AF; Mon, 14 Apr 2025 10:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u4L64-0006jz-A3
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:47:42 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u4L61-0001KJ-Oa
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:47:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1744642034; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E0FC9Nc0zb040YHBPfdYvsoHHPYnpIM3b7n5MOhH/yIXlWqLINsfMdxA0iZdb3QtGO1tziakHR6cF9XBfKFagddIkuYGr9AqbvmwJ5bfj1rAzjowd0z6e6gVqEkgIpIdT1TVUNicd3HhEP/wb7qbCMKbzykuMqBcxo2zLhqZSyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1744642034;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=K4TAWU93SxcHR0bz4xFsv0c9lMbZZvlnvYLfJohOjl8=; 
 b=clg6pbfhpPCCfoycI+x24pQZGh4AzvkQdqQKNCQTJBwUCf6mCUF6rcnAD87Ae7ZfukKGRamUtlSKQ+Cd8Z3WLLT4Kz6zsg+BP1u00s6IL+pAFytZhDpsV3eHA85lqh/BSZ3f2QnfWHwZpHuX5c4hq+81pUeuVc0ZSa4kLoE2Wzw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744642034; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=K4TAWU93SxcHR0bz4xFsv0c9lMbZZvlnvYLfJohOjl8=;
 b=in4tuCB23D+1Ml/nxSLVaE3zYZbQbWR15/RWVFrvTuIoyzOnByuXtHeYe94sJLup
 qdOaTsgIJrB34XOJxHCTQ7ehpVKj8WuC7x92kAJPQJl/loabyrwhZk1gPH9WSotAf+G
 fLFqrbFQtsotefGGM6ZiiTv3dVcxVnV4HKg6G/pM=
Received: by mx.zohomail.com with SMTPS id 1744642032677107.94954364045145;
 Mon, 14 Apr 2025 07:47:12 -0700 (PDT)
Message-ID: <425ebb80-4348-46f3-878b-054800a8fe85@collabora.com>
Date: Mon, 14 Apr 2025 17:47:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
To: =?UTF-8?B?5YiY6IGq?= <liucong2565@phytium.com.cn>
Cc: Jiqian.Chen@amd.com, akihiko.odaki@daynix.com, alex.bennee@linaro.org,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 gert.wollny@collabora.com, gurchetansingh@chromium.org, hi@alyssa.is,
 honglei1.huang@amd.com, julia.zhang@amd.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 philmd@linaro.org, pierre-eric.pelloux-prayer@amd.com,
 qemu-devel@nongnu.org, ray.huang@amd.com, robdclark@gmail.com,
 roger.pau@citrix.com, slp@redhat.com, stefano.stabellini@amd.com,
 xenia.ragiadakou@amd.com, zzyiwei@chromium.org
References: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
 <20250410095454.188105-1-liucong2565@phytium.com.cn>
 <d0e9e72a-02bf-4f1e-abe0-6e8d0d089b29@collabora.com>
 <5514d916.6d34.19622831b11.Coremail.liucong2565@phytium.com.cn>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <5514d916.6d34.19622831b11.Coremail.liucong2565@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/11/25 04:42, 刘聪 wrote:
> 
> 
> 
>> -----Original Messages-----
>> From: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
>> Send time:Friday, 04/11/2025 05:59:11
>> To: "Cong Liu" <liucong2565@phytium.com.cn>
>> Cc: Jiqian.Chen@amd.com, akihiko.odaki@daynix.com, alex.bennee@linaro.org, alexander.deucher@amd.com, christian.koenig@amd.com, gert.wollny@collabora.com, gurchetansingh@chromium.org, hi@alyssa.is, honglei1.huang@amd.com, julia.zhang@amd.com, kraxel@redhat.com, marcandre.lureau@redhat.com, mst@redhat.com, pbonzini@redhat.com, philmd@linaro.org, pierre-eric.pelloux-prayer@amd.com, qemu-devel@nongnu.org, ray.huang@amd.com, robdclark@gmail.com, roger.pau@citrix.com, slp@redhat.com, stefano.stabellini@amd.com, xenia.ragiadakou@amd.com, zzyiwei@chromium.org
>> Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
>>
>> 10.04.2025 12:54, Cong Liu пишет:
>>> I discovered that on an ARM64 environment, the 'virtio-gpu: Support asynchronous fencing' patch causes the virtual machine GUI to fail to display. Rolling back this patch and using virgl allows the virtual machine to start normally. When the VM screen is black, I can see some errors in QEMU. I used QEMU's -serial stdio to enter the virtual machine's command line console but didn't see any errors inside the VM - the graphical interface seems to be stuck. I would greatly appreciate any suggestions regarding effective troubleshooting methods or specific areas I should investigate to resolve this issue.
>>>
>>> Here's my software and hardware environment:
>>> - host and guest are ubuntu 24.04
>>> - QEMU: https://gitlab.freedesktop.org/digetx/qemu.git native-context-v11 branch
>>> - virglrender: latest main branch 08eb12d00711370002e8f8fa6d620df9b79f9e27
>>> - Mesa: Mesa 25.0~git2504031308.ff386e~oibaf~n (git-ff386eb 2025-04-03 noble-oibaf-ppa)
>>> - Kernel: Linux d3000 6.14.1-061401-generic #202504071048
>>> - GPU: Radeon RX 6600/6600 XT/6600M
>>> - CPU: phytium D3000 aarch64
>>>
>>> Here's the command I'm using to run the virtual machine, which displays a black frame with "Display output is not active" and fails to start the graphical interface normally:
>>>
>>>     phytium@d3000:~/working/qemu$ /usr/local/bin/qemu-system-aarch64 --machine virt,accel=kvm -cpu host -smp 4 -m 4G -drive file=/home/phytium/working/ubuntu24.04-aarch64-native-context,format=raw,if=virtio -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -device virtio-gpu-gl -display gtk,gl=on,show-cursor=on -device usb-ehci,id=usb -device usb-mouse,bus=usb.0 -device usb-kbd,bus=usb.0
>>>
>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
>>>     (qemu:46029): Gdk-WARNING **: 16:43:53.716: eglMakeCurrent failed
>>>
>>> When using SDL, the error messages are slightly different:
>>>
>>>     phytium@d3000:~/working/qemu$ /usr/local/bin/qemu-system-aarch64 --machine virt,accel=kvm -cpu host -smp 4 -m 4G -drive file=/home/phytium/working/ubuntu24.04-aarch64-native-context,format=raw,if=virtio -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -device virtio-gpu-gl -display sdl,gl=on,show-cursor=on -device usb-ehci,id=usb -device usb-mouse,bus=usb.0 -device usb-kbd,bus=usb.0
>>>
>>>     vrend_renderer_fill_caps: Entering with stale GL error: 1286
>>>
>>
>> Hi,
>>
>> 1. Please make sure that you're not only building QEMU against your
>> virglrenderer version, but also setting LD_LIBRARY_PATH properly at
>> runtime. Best to remove system version of virglrenderer if unsure,
> 
> I built and installed virglrenderer with the --prefix=/usr option, so
>  it replaces the system version as expected.
> 
>>
>> 2. Can you reproduce this problem using tcg instead of kvm?
>>
> 
>  yes, change qemu command '--machine virt,accel=kvm -cpu host' to
> '--machine virt -cpu max' can reproduce this problem. 
>> -- 
>> Best regards,
>> Dmitry
> 
> diff --git a/src/vrend_renderer.c b/src/vrend_renderer.c
> index f6df9dcb..f6e06842 100644
> --- a/src/vrend_renderer.c
> +++ b/src/vrend_renderer.c
> @@ -12808,7 +12808,7 @@ void vrend_renderer_fill_caps(uint32_t set, uint32_t version,
>                                union virgl_caps *caps)
>  {
>     int gl_ver, gles_ver;
> -   GLenum err;
> +   GLenum err = GL_NO_ERROR;
>     bool fill_capset2 = false;
>  
>     if (!caps)
> 
> phytium@d3000:~/working/qemu$ git log --oneline  -n 10
> e0286f56c8 (HEAD -> native-context-v11, origin/native-context-v11) Revert "amd_iommu: Add support for pass though mode"
> d6e9eb0f0d docs/system: virtio-gpu: Document host/guest requirements
> 55db821ea5 docs/system: virtio-gpu: Update Venus link
> 003940db9a docs/system: virtio-gpu: Add link to Mesa VirGL doc
> 7674e82755 ui/gtk: Don't disable scanout when display is refreshed
> 712fd024e3 ui/sdl2: Don't disable scanout when display is refreshed
> 9003da356f virtio-gpu: Support DRM native context
> e2ff4f4a48 virtio-gpu: Support asynchronous fencing
> 25458c7625 virtio-gpu: Handle virgl fence creation errors
> 
> I tried initializing GLenum err = GL_NO_ERROR in vrend_renderer_fill_caps, but it doesn’t seem to resolve the “Entering with stale GL error: 1286” message. However, this error might not be directly related to the VM black screen issue. I noticed that even when the VM was working correctly—specifically when I reset to commit 25458c7625—the same GL error still appeared.

Thanks for the report. I confirm that something is wrong with virgl when
async fencing is used. Don't have this GL 1286 error, but getting a
lockup on ARM VM and with one of my new x64 VM setups. Will investigate
further and report back here.

-- 
Best regards,
Dmitry

