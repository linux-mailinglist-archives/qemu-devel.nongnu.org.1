Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B6091E9C6
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jul 2024 22:45:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONs0-0003jk-U5; Mon, 01 Jul 2024 16:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONry-0003hv-DF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONrv-0005ve-6L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719866601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZ7jAA20oKlZJIQmzBXt+JUScNJqFKXsGvEtA9COa+o=;
 b=c8vZHV0Fu3cj2GxSG6Zz0pF9nUI4zALc2OzHjmk0+v0vsCA7/UKfNaoNbEXi8HLgVW6auZ
 5mI7Nj7M2pWKKJKTNOVI4G9KvjacL+HZ69QM6X8upgzyJIqMX7UEDl3cTzIxFBe4AtROpw
 vAvevkKjTDQNh6LnRqn8MwJ2PhI1bSM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ERTs3cZGN4enMQHE83mjqQ-1; Mon, 01 Jul 2024 16:43:20 -0400
X-MC-Unique: ERTs3cZGN4enMQHE83mjqQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52cdec8a6a7so3055454e87.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719866599; x=1720471399;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZ7jAA20oKlZJIQmzBXt+JUScNJqFKXsGvEtA9COa+o=;
 b=QWO3bboxpJmk3jkcy7cm6UPoCija+H6eOad7/B+h+vvGy6DJPt9AKDLjnlBmzRaycM
 DMXUKSk6BQbSFyY3ZTaOV2vpuw2eeRPAwCMvCR0P6zgvSnOtJLiFx+ucMFJwgnyK5iaA
 IXl9pZwwDyGnslMeSoNdv+RtiK1NRR0GTcMwBstGP6RMn+HJwAg8BwN4ahkq7kRgb6m2
 G7snvEs6CKJDcP+II9on5w0rrSv+Pw3Sr5r1DI+/K55irfHr3rYCNNPI/I9phEOE0pVS
 Ndu8IlLzvNRCTV1blHBhTcEpCVxeB91clKtnl4tNuGc4AgvA4nNDNJocDZ+f+q1x6x/d
 /gPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9VufVuAzB+ZGMw4et/eRDCKs13eGlZ5Fj7j3b8YQ/3zokbflVxyJ5vrPXPxbsU8T/AXMxXwZfMlww/GMZtcHu6IPV0Qo=
X-Gm-Message-State: AOJu0Yzzz04WKq3PubVk906HVS1iqvuTziauD6vyFxJZB+x3bop2Mgbq
 M7Z9jZ4GNh486r7GD5SdT5QBa/FHstvs3GBIalHtj3DdkPvEbOHD5f1w5oAOYKbqC/Z1SQ4AmUZ
 zJMNIphHPQv6s9IfHpCbd6/GuUsPVGxBeeH3Y+/eeYalS2oMJYiK+
X-Received: by 2002:a05:6512:b9d:b0:52c:dba6:b4cb with SMTP id
 2adb3069b0e04-52e8264df75mr5006566e87.13.1719866598809; 
 Mon, 01 Jul 2024 13:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc6ORyVv3EtcZ2aLd0YK8aE/Cr5dLujil4gZtpheeTAMomo0N/pEfH+/4kLkGq9kbD50k4kw==
X-Received: by 2002:a05:6512:b9d:b0:52c:dba6:b4cb with SMTP id
 2adb3069b0e04-52e8264df75mr5006541e87.13.1719866597945; 
 Mon, 01 Jul 2024 13:43:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55d0fsm166473765e9.19.2024.07.01.13.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:43:17 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:43:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v16 00/13] Support blob memory and venus on qemu
Message-ID: <20240701164236-mutt-send-email-mst@kernel.org>
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <CAJ+F1CL84ZYtHq+6rVrFYerEhuRvczi1pb5Nui8BeyRqMygaVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL84ZYtHq+6rVrFYerEhuRvczi1pb5Nui8BeyRqMygaVQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 01, 2024 at 02:48:58PM +0400, Marc-André Lureau wrote:
> Hi,
> 
> All R-b now, it looks good to merge. Thanks for all the effort! 
> 
> Michael, are you taking it through your tree?


I could but did you intend to give your Reviewed-by?


> On Sun, Jun 23, 2024 at 7:23 PM Dmitry Osipenko <dmitry.osipenko@collabora.com>
> wrote:
> 
>     Hello,
> 
>     This series enables Vulkan Venus context support on virtio-gpu.
> 
>     All virglrender and almost all Linux kernel prerequisite changes
>     needed by Venus are already in upstream. For kernel there is a pending
>     KVM patchset that fixes mapping of compound pages needed for DRM drivers
>     using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
>     from Qemu.
> 
>     [1] https://lore.kernel.org/kvm/
>     20240229025759.1187910-1-stevensd@google.com/
> 
>     You'll need to use recent Mesa version containing patch that removes
>     dependency on cross-device feature from Venus that isn't supported by
>     Qemu [2].
> 
>     [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/
>     087e9a96d13155e26987befae78b6ccbb7ae242b
> 
>     Example Qemu cmdline that enables Venus:
> 
>       qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=true,venus=true
>     \
>           -machine q35,accel=kvm,memory-backend=mem1 \
>           -object memory-backend-memfd,id=mem1,size=8G -m 8G
> 
> 
>     Changes from V15 to V16
> 
>     - Fixed resource_get_info() change made in v15 that was squshed into a
>       wrong patch. Squashed set_scanout_blob patch into the blob-commands
>     patch,
>       otherwise we'll need to revert back ordering of blob patches to older v7
>       variant.
> 
>     - Changed hostmem mapping state to boolean, suggested by Akihiko Odaki.
> 
>     - Documented Venus in virtio-gpu doc. Amended "Support Venus context" patch
>       with the doc addition. Suggested by Akihiko Odaki.
> 
>     Changes from V14 to V15
> 
>     - Dropped hostmem mapping state that got unused in v14, suggested by
>       Akihiko Odaki.
> 
>     - Moved resource_get_info() from set_scanout_blob() to create_blob(),
>       suggested by Akihiko Odaki.
> 
>     - Fixed unitilized variable in create_blob(), spotted by Alex Bennée.
> 
>     Changes from V13 to V14
> 
>     - Fixed erronous fall-through in renderer_state's switch-case that was
>       spotted by Marc-André Lureau.
> 
>     - Reworked HOSTMEM_MR_FINISH_UNMAPPING handling as was suggested by
>       Akihiko Odaki. Now it shares the same code path with HOSTMEM_MR_MAPPED.
> 
>     - Made use of g_autofree in virgl_cmd_resource_create_blob() as was
>       suggested by Akihiko Odaki.
> 
>     - Removed virtio_gpu_virgl_deinit() and moved all deinit code to
>       virtio_gpu_gl_device_unrealize() as was suggested by Marc-André Lureau.
> 
>     - Replaced HAVE_FEATURE in mseon.build with virglrenderer's VERSION_MAJOR
>       check as was suggested by Marc-André Lureau.
> 
>     - Added trace event for cmd-suspension as was suggested by Marc-André
>     Lureau.
> 
>     - Added patch to replace in-flight printf's with trace events as was
>       suggested by Marc-André Lureau
> 
>     Changes from V12 to V13
> 
>     - Replaced `res->async_unmap_in_progress` flag with a mapping state,
>       moved it to the virtio_gpu_virgl_hostmem_region like was suggested
>       by Akihiko Odaki.
> 
>     - Renamed blob_unmap function and added back cmd_suspended argument
>       to it. Suggested by Akihiko Odaki.
> 
>     - Reordered VirtIOGPUGL refactoring patches to minimize code changes
>       like was suggested by Akihiko Odaki.
> 
>     - Replaced gl->renderer_inited with gl->renderer_state, like was suggested
>       by Alex Bennée.
> 
>     - Added gl->renderer state resetting to gl_device_unrealize(), for
>       consistency. Suggested by Alex Bennée.
> 
>     - Added rb's from Alex and Manos.
> 
>     - Fixed compiling with !HAVE_VIRGL_RESOURCE_BLOB.
> 
>     Changes from V11 to V12
> 
>     - Fixed virgl_cmd_resource_create_blob() error handling. Now it doesn't
>       corrupt resource list and releases resource properly on error. Thanks
>       to Akihiko Odaki for spotting the bug.
> 
>     - Added new patch that handles virtio_gpu_virgl_init() failure gracefully,
>       fixing Qemu crash. Besides fixing the crash, it allows to implement
>       a cleaner virtio_gpu_virgl_deinit().
> 
>     - virtio_gpu_virgl_deinit() now assumes that previously virgl was
>       initialized successfully when it was inited at all. Suggested by
>       Akihiko Odaki.
> 
>     - Fixed missed freeing of print_stats timer in virtio_gpu_virgl_deinit()
> 
>     - Added back blob unmapping or RESOURCE_UNREF that was requested
>       by Akihiko Odaki. Added comment to the code explaining how
>       async unmapping works. Added back `res->async_unmap_in_progress`
>       flag and added comment telling why it's needed.
> 
>     - Moved cmdq_resume_bh to VirtIOGPUGL and made coding style changes
>       suggested by Akihiko Odaki.
> 
>     - Added patches that move fence_poll and print_stats timers to VirtIOGPUGL
>       for consistency with cmdq_resume_bh.
> 
>     Changes from V10 to V11
> 
>     - Replaced cmd_resume bool in struct ctrl_command with
>       "cmd->finished + !VIRTIO_GPU_FLAG_FENCE" checking as was requested
>       by Akihiko Odaki.
> 
>     - Reworked virgl_cmd_resource_unmap/unref_blob() to avoid re-adding
>       the 'async_unmap_in_progress' flag that was dropped in v9:
> 
>         1. virgl_cmd_resource_[un]map_blob() now doesn't check itself whether
>            resource was previously mapped and lets virglrenderer to do the
>            checking.
> 
>         2. error returned by virgl_renderer_resource_unmap() is now handled
>            and reported properly, previously the error wasn't checked. The
>            virgl_renderer_resource_unmap() fails if resource wasn't mapped.
> 
>         3. virgl_cmd_resource_unref_blob() now doesn't allow to unref resource
>            that is mapped, it's a error condition if guest didn't unmap
>     resource
>            before doing the unref. Previously unref was implicitly unmapping
>            resource.
> 
>     Changes from V9 to V10
> 
>     - Dropped 'async_unmap_in_progress' variable and switched to use
>       aio_bh_new() isntead of oneshot variant in the "blob commands" patch.
> 
>     - Further improved error messages by printing error code when actual error
>       occurrs and using ERR_UNSPEC instead of ERR_ENOMEM when we don't really
>       know if it was ENOMEM for sure.
> 
>     - Added vdc->unrealize for the virtio GL device and freed virgl data.
> 
>     - Dropped UUID and doc/migration patches. UUID feature isn't needed
>       anymore, instead we changed Mesa Venus driver to not require UUID.
> 
>     - Renamed virtio-gpu-gl "vulkan" property name back to "venus".
> 
>     Changes from V8 to V9
> 
>     - Added resuming of cmdq processing when hostmem MR is freed,
>       as was suggested by Akihiko Odaki.
> 
>     - Added more error messages, suggested by Akihiko Odaki
> 
>     - Dropped superfluous 'res->async_unmap_completed', suggested
>       by Akihiko Odaki.
> 
>     - Kept using cmd->suspended flag. Akihiko Odaki suggested to make
>       virtio_gpu_virgl_process_cmd() return false if cmd processing is
>       suspended, but it's not easy to implement due to ubiquitous
>       VIRTIO_GPU_FILL_CMD() macros that returns void, requiring to change
>       all the virtio-gpu processing code.
> 
>     - Added back virtio_gpu_virgl_resource as was requested by Akihiko Odaki,
>       though I'm not convinced it's really needed.
> 
>     - Switched to use GArray, renamed capset2_max_ver/size vars and moved
>       "vulkan" property definition to the virtio-gpu-gl device in the Venus
>       patch, like was suggested by Akihiko Odaki.
> 
>     - Moved UUID to virtio_gpu_virgl_resource and dropped UUID save/restore
>       since it will require bumping VM version and virgl device isn't miratable
>       anyways.
> 
>     - Fixed exposing UUID feature with Rutabaga
> 
>     - Dropped linux-headers update patch because headers were already updated
>       in Qemu/staging.
> 
>     - Added patch that updates virtio migration doc with a note about
>     virtio-gpu
>       migration specifics, suggested by Akihiko Odaki.
> 
>     - Addressed coding style issue noticed by Akihiko Odaki
> 
>     Changes from V7 to V8
> 
>     - Supported suspension of virtio-gpu commands processing and made
>       unmapping of hostmem region asynchronous by blocking/suspending
>       cmd processing until region is unmapped. Suggested by Akihiko Odaki.
> 
>     - Fixed arm64 building of x86 targets using updated linux-headers.
>       Corrected the update script. Thanks to Rob Clark for reporting
>       the issue.
> 
>     - Added new patch that makes registration of virgl capsets dynamic.
>       Requested by Antonio Caggiano and Pierre-Eric Pelloux-Prayer.
> 
>     - Venus capset now isn't advertised if Vulkan is disabled with vulkan=false
> 
>     Changes from V6 to V7
> 
>     - Used scripts/update-linux-headers.sh to update Qemu headers based
>       on Linux v6.8-rc3 that adds Venus capset definition to virtio-gpu
>       protocol, was requested by Peter Maydel
> 
>     - Added r-bs that were given to v6 patches. Corrected missing s-o-bs
> 
>     - Dropped context_init Qemu's virtio-gpu device configuration flag,
>       was suggested by Marc-André Lureau
> 
>     - Added missing error condition checks spotted by Marc-André Lureau
>       and Akihiko Odaki, and few more
> 
>     - Returned back res->mr referencing to memory_region_init_ram_ptr() like
>       was suggested by Akihiko Odaki. Incorporated fix suggested by Pierre-Eric
>       to specify the MR name
> 
>     - Dropped the virgl_gpu_resource wrapper, cleaned up and simplified
>       patch that adds blob-cmd support
> 
>     - Fixed improper blob resource removal from resource list on resource_unref
>       that was spotted by Akihiko Odaki
> 
>     - Change order of the blob patches, was suggested by Akihiko Odaki.
>       The cmd_set_scanout_blob support is enabled first
> 
>     - Factored out patch that adds resource management support to
>     virtio-gpu-gl,
>       was requested by Marc-André Lureau
> 
>     - Simplified and improved the UUID support patch, dropped the hash table
>       as we don't need it for now. Moved QemuUUID to
>     virtio_gpu_simple_resource.
>       This all was suggested by Akihiko Odaki and Marc-André Lureau
> 
>     - Dropped console_has_gl() check, suggested by Akihiko Odaki
> 
>     - Reworked Meson cheking of libvirglrender features, made new features
>       available based on virglrender pkgconfig version instead of checking
>       symbols in header. This should fix build error using older virglrender
>       version, reported by Alex Bennée
> 
>     - Made enabling of Venus context configrable via new virtio-gpu device
>       "vulkan=true" flag, suggested by Marc-André Lureau. The flag is disabled
>       by default because it requires blob and hostmem options to be enabled
>       and configured
> 
>     Changes from V5 to V6
> 
>     - Move macros configurations under virgl.found() and rename
>       HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS.
> 
>     - Handle the case while context_init is disabled.
> 
>     - Enable context_init by default.
> 
>     - Move virtio_gpu_virgl_resource_unmap() into
>       virgl_cmd_resource_unmap_blob().
> 
>     - Introduce new struct virgl_gpu_resource to store virgl specific members.
> 
>     - Remove erro handling of g_new0, because glib will abort() on OOM.
> 
>     - Set resource uuid as option.
> 
>     - Implement optional subsection of vmstate_virtio_gpu_resource_uuid_state
>       for virtio live migration.
> 
>     - Use g_int_hash/g_int_equal instead of the default
> 
>     - Add scanout_blob function for virtio-gpu-virgl
> 
>     - Resolve the memory leak on virtio-gpu-virgl
> 
>     - Remove the unstable API flags check because virglrenderer is already 1.0
> 
>     - Squash the render server flag support into "Initialize Venus"
> 
>     Changes from V4 (virtio gpu V4) to V5
> 
>     - Inverted patch 5 and 6 because we should configure
>       HAVE_VIRGL_CONTEXT_INIT firstly.
> 
>     - Validate owner of memory region to avoid slowing down DMA.
> 
>     - Use memory_region_init_ram_ptr() instead of
>       memory_region_init_ram_device_ptr().
> 
>     - Adjust sequence to allocate gpu resource before virglrender resource
>       creation
> 
>     - Add virtio migration handling for uuid.
> 
>     - Send kernel patch to define VIRTIO_GPU_CAPSET_VENUS.
>       https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/
> 
>     - Add meson check to make sure unstable APIs defined from 0.9.0.
> 
>     Changes from V1 to V2 (virtio gpu V4)
> 
>     - Remove unused #include "hw/virtio/virtio-iommu.h"
> 
>     - Add a local function, called virgl_resource_destroy(), that is used
>       to release a vgpu resource on error paths and in resource_unref.
> 
>     - Remove virtio_gpu_virgl_resource_unmap from
>       virtio_gpu_cleanup_mapping(),
>       since this function won't be called on blob resources and also because
>       blob resources are unmapped via virgl_cmd_resource_unmap_blob().
> 
>     - In virgl_cmd_resource_create_blob(), do proper cleanup in error paths
>       and move QTAILQ_INSERT_HEAD(&g->reslist, res, next) after the resource
>       has been fully initialized.
> 
>     - Memory region has a different life-cycle from virtio gpu resources
>       i.e. cannot be released synchronously along with the vgpu resource.
>       So, here the field "region" was changed to a pointer and is allocated
>       dynamically when the blob is mapped.
>       Also, since the pointer can be used to indicate whether the blob
>       is mapped, the explicite field "mapped" was removed.
> 
>     - In virgl_cmd_resource_map_blob(), add check on the value of
>       res->region, to prevent beeing called twice on the same resource.
> 
>     - Add a patch to enable automatic deallocation of memory regions to resolve
>       use-after-free memory corruption with a reference.
> 
> 
>     Antonio Caggiano (1):
>       virtio-gpu: Support Venus context
> 
>     Dmitry Osipenko (8):
>       virtio-gpu: Use trace events for tracking number of in-flight fences
>       virtio-gpu: Move fence_poll timer to VirtIOGPUGL
>       virtio-gpu: Move print_stats timer to VirtIOGPUGL
>       virtio-gpu: Handle virtio_gpu_virgl_init() failure
>       virtio-gpu: Unrealize GL device
>       virtio-gpu: Use pkgconfig version to decide which virgl features are
>         available
>       virtio-gpu: Don't require udmabuf when blobs and virgl are enabled
>       virtio-gpu: Support suspension of commands processing
> 
>     Huang Rui (2):
>       virtio-gpu: Support context-init feature with virglrenderer
>       virtio-gpu: Add virgl resource management
> 
>     Pierre-Eric Pelloux-Prayer (1):
>       virtio-gpu: Register capsets dynamically
> 
>     Robert Beckett (1):
>       virtio-gpu: Handle resource blob commands
> 
>      docs/system/devices/virtio-gpu.rst |  11 +
>      hw/display/trace-events            |   3 +
>      hw/display/virtio-gpu-gl.c         |  62 ++-
>      hw/display/virtio-gpu-virgl.c      | 585 +++++++++++++++++++++++++++--
>      hw/display/virtio-gpu.c            |  44 ++-
>      include/hw/virtio/virtio-gpu.h     |  32 +-
>      meson.build                        |   5 +-
>      7 files changed, 685 insertions(+), 57 deletions(-)
> 
>     --
>     2.45.2
> 
> 
> 
> 
> --
> Marc-André Lureau


