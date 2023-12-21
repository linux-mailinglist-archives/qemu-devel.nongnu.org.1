Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D164F81BB6F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 17:02:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGLTi-0000re-L0; Thu, 21 Dec 2023 11:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGLTd-0000rE-RW
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 11:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGLTa-0004tS-Te
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 11:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703174444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJkPmwciD00Iav5Mjd01crxLNt+K0fu/II421Y3s5No=;
 b=fFsUG53bTok5VYYLrTKtMIKkhUfj/nKZuczgKBS2chkK/2uxk5Y/UJSTE9RDMafoPinciB
 RL2w53xJkqR+fs3INF2Hfi5YKPV6m009/pt6lQNqhbTS3+bMQloY3aCXuYcIct9OZVRmq4
 hmQv4ZTj1NKfH+9ya2qT/nXJJyYmcvs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-DwQtoGoSNwKkrV66tYD9JQ-1; Thu, 21 Dec 2023 11:00:42 -0500
X-MC-Unique: DwQtoGoSNwKkrV66tYD9JQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b8b66d49easo878583b6e.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 08:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703174441; x=1703779241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJkPmwciD00Iav5Mjd01crxLNt+K0fu/II421Y3s5No=;
 b=MArxLUPmgjSebZBoQozZ8biLh7P7F8+vaHEKcpDzQ43jacxo93IIAZUa+eOb8G8j4O
 k8HbVY79Q/p17Jpc3Ze8HvOAHO1+Bcrf8X+JWoPJOjaegW5mCnx10jIGM38HR/ZClfl2
 u8rEHGuh++b45Q0i1TUoG3y3Qv6+ZJZe4xioO8ie3LP+7NHJcNFxXAI8eUukjso0S8ZF
 px5OA3iZ3rV9gRvMlcD/JbWqkG7qDxg1gmMOfWV2xbJt6AHvpn0lnqNoC1yhd4YPanwR
 IccceT+moz9UyrsTND9eBWmktu6LV5h9lQcX9GesxAyNMVwWtL1P89wFFrM9xJeHQJ1J
 Hzug==
X-Gm-Message-State: AOJu0Yy/Lw43hhf83Txy6PV4LG2uOxnGOVpALH754RjTUVIdBWC3smab
 edlCiOrkMEfQRtyqhvjFiyB0MDjLC7WPlt80btD71GxabvXYGjCDWLzVkFGMAnQW6EdpCDmo2HX
 6Q8mbh/4+qM7LA9t4tXLCL9zcmkSCENGsJZZb6JVbL1Aul555JdxmBeBgdswNCgqP4WAk
X-Received: by 2002:a05:6358:7e12:b0:170:4035:4f94 with SMTP id
 o18-20020a0563587e1200b0017040354f94mr1412522rwm.25.1703174441005; 
 Thu, 21 Dec 2023 08:00:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCZpSG3c5b6f2mhcW6LQxL+KGufpcgQessOicDOnMtdwQqFTbmXQ8L5lM1GYJRDsAiHWWH9A==
X-Received: by 2002:a05:6358:7e12:b0:170:4035:4f94 with SMTP id
 o18-20020a0563587e1200b0017040354f94mr1412499rwm.25.1703174440621; 
 Thu, 21 Dec 2023 08:00:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 jc4-20020a05622a714400b004255183b1a4sm924907qtb.64.2023.12.21.08.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:00:40 -0800 (PST)
Message-ID: <c6daa302-8da3-4931-812d-88dbb156a17a@redhat.com>
Date: Thu, 21 Dec 2023 17:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/47] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20231219185643.725448-1-clg@redhat.com>
 <20231219185643.725448-21-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231219185643.725448-21-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

[ ... ]


> +static void iommufd_backend_init(Object *obj)
> +{
> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
> +
> +    be->fd = -1;
> +    be->users = 0;
> +    be->owned = true;
> +    qemu_mutex_init(&be->lock);> +}
> +
> +static void iommufd_backend_finalize(Object *obj)
> +{
> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
> +
> +    if (be->owned) {
> +        close(be->fd);
> +        be->fd = -1;
> +    }
> +}
> +
> +static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
> +{
> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
> +    int fd = -1;
> +
> +    fd = monitor_fd_param(monitor_cur(), str, errp);
> +    if (fd == -1) {
> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
> +        return;
> +    }
> +    qemu_mutex_lock(&be->lock);
> +    be->fd = fd;
> +    be->owned = false;
> +    qemu_mutex_unlock(&be->lock);
> +    trace_iommu_backend_set_fd(be->fd);
> +}
> +
> +static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
> +{
> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
> +
> +    return !be->users;

Coverity CID 1531549 reports a concurrent data access violation because
be->users is being accessed without holding the mutex.

I wonder how useful is this mutex anyhow, since the code paths should
be protected by the BQL lock. If you agree, I will send an update to
simply drop be->lock and solve this report.

Thanks,

C.



> +}
> +
> +static void iommufd_backend_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +
> +    ucc->can_be_deleted = iommufd_backend_can_be_deleted;
> +
> +    object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
> +}
> +
> +int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
> +{
> +    int fd, ret = 0;
> +
> +    qemu_mutex_lock(&be->lock);
> +    if (be->users == UINT32_MAX) {
> +        error_setg(errp, "too many connections");
> +        ret = -E2BIG;
> +        goto out;
> +    }
> +    if (be->owned && !be->users) {
> +        fd = qemu_open_old("/dev/iommu", O_RDWR);
> +        if (fd < 0) {
> +            error_setg_errno(errp, errno, "/dev/iommu opening failed");
> +            ret = fd;
> +            goto out;
> +        }
> +        be->fd = fd;
> +    }
> +    be->users++;
> +out:
> +    trace_iommufd_backend_connect(be->fd, be->owned,
> +                                  be->users, ret);
> +    qemu_mutex_unlock(&be->lock);
> +    return ret;
> +}
> +
> +void iommufd_backend_disconnect(IOMMUFDBackend *be)
> +{
> +    qemu_mutex_lock(&be->lock);
> +    if (!be->users) {
> +        goto out;
> +    }
> +    be->users--;
> +    if (!be->users && be->owned) {
> +        close(be->fd);
> +        be->fd = -1;
> +    }
> +out:
> +    trace_iommufd_backend_disconnect(be->fd, be->users);
> +    qemu_mutex_unlock(&be->lock);
> +}
> +
> +int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
> +                               Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_ioas_alloc alloc_data  = {
> +        .size = sizeof(alloc_data),
> +        .flags = 0,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to allocate ioas");
> +        return ret;
> +    }
> +
> +    *ioas_id = alloc_data.out_ioas_id;
> +    trace_iommufd_backend_alloc_ioas(fd, *ioas_id, ret);
> +
> +    return ret;
> +}
> +
> +void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_destroy des = {
> +        .size = sizeof(des),
> +        .id = id,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_DESTROY, &des);
> +    trace_iommufd_backend_free_id(fd, id, ret);
> +    if (ret) {
> +        error_report("Failed to free id: %u %m", id);
> +    }
> +}
> +
> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
> +                            ram_addr_t size, void *vaddr, bool readonly)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_ioas_map map = {
> +        .size = sizeof(map),
> +        .flags = IOMMU_IOAS_MAP_READABLE |
> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
> +        .ioas_id = ioas_id,
> +        .__reserved = 0,
> +        .user_va = (uintptr_t)vaddr,
> +        .iova = iova,
> +        .length = size,
> +    };
> +
> +    if (!readonly) {
> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
> +    }
> +
> +    ret = ioctl(fd, IOMMU_IOAS_MAP, &map);
> +    trace_iommufd_backend_map_dma(fd, ioas_id, iova, size,
> +                                  vaddr, readonly, ret);
> +    if (ret) {
> +        ret = -errno;
> +
> +        /* TODO: Not support mapping hardware PCI BAR region for now. */
> +        if (errno == EFAULT) {
> +            warn_report("IOMMU_IOAS_MAP failed: %m, PCI BAR?");
> +        } else {
> +            error_report("IOMMU_IOAS_MAP failed: %m");
> +        }
> +    }
> +    return ret;
> +}
> +
> +int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> +                              hwaddr iova, ram_addr_t size)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_ioas_unmap unmap = {
> +        .size = sizeof(unmap),
> +        .ioas_id = ioas_id,
> +        .iova = iova,
> +        .length = size,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
> +    /*
> +     * IOMMUFD takes mapping as some kind of object, unmapping
> +     * nonexistent mapping is treated as deleting a nonexistent
> +     * object and return ENOENT. This is different from legacy
> +     * backend which allows it. vIOMMU may trigger a lot of
> +     * redundant unmapping, to avoid flush the log, treat them
> +     * as succeess for IOMMUFD just like legacy backend.
> +     */
> +    if (ret && errno == ENOENT) {
> +        trace_iommufd_backend_unmap_dma_non_exist(fd, ioas_id, iova, size, ret);
> +        ret = 0;
> +    } else {
> +        trace_iommufd_backend_unmap_dma(fd, ioas_id, iova, size, ret);
> +    }
> +
> +    if (ret) {
> +        ret = -errno;
> +        error_report("IOMMU_IOAS_UNMAP failed: %m");
> +    }
> +    return ret;
> +}
> +
> +static const TypeInfo iommufd_backend_info = {
> +    .name = TYPE_IOMMUFD_BACKEND,
> +    .parent = TYPE_OBJECT,
> +    .instance_size = sizeof(IOMMUFDBackend),
> +    .instance_init = iommufd_backend_init,
> +    .instance_finalize = iommufd_backend_finalize,
> +    .class_size = sizeof(IOMMUFDBackendClass),
> +    .class_init = iommufd_backend_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&iommufd_backend_info);
> +}
> +
> +type_init(register_types);
> diff --git a/backends/Kconfig b/backends/Kconfig
> index f35abc16092808b1fe5b033a346908e2d66bff0b..2cb23f62fa1526cedafedcc99a032e098075b846 100644
> --- a/backends/Kconfig
> +++ b/backends/Kconfig
> @@ -1 +1,5 @@
>   source tpm/Kconfig
> +
> +config IOMMUFD
> +    bool
> +    depends on VFIO
> diff --git a/backends/meson.build b/backends/meson.build
> index 914c7c4afb905cfe710ad23dd1ee42907f6d1679..9a5cea480d172d50a641e4d9179093e8155f2db1 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -20,6 +20,7 @@ if have_vhost_user
>     system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('vhost-user.c'))
>   endif
>   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
> +system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
>   if have_vhost_user_crypto
>     system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
>   endif
> diff --git a/backends/trace-events b/backends/trace-events
> index 652eb76a5723e2053fe97338c481309c58284d6a..d45c6e31a67ed66d94787f60eb08a525cf6ff68b 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -5,3 +5,13 @@ dbus_vmstate_pre_save(void)
>   dbus_vmstate_post_load(int version_id) "version_id: %d"
>   dbus_vmstate_loading(const char *id) "id: %s"
>   dbus_vmstate_saving(const char *id) "id: %s"
> +
> +# iommufd.c
> +iommufd_backend_connect(int fd, bool owned, uint32_t users, int ret) "fd=%d owned=%d users=%d (%d)"
> +iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
> +iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
> +iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
> +iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
> +iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
> +iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
> +iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 42fd09e4de96e962cd5873c49501f6e1dbb5e346..5fe8ea57d2d2f9390a976ef2fefe86463e888bb1 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5224,6 +5224,18 @@ SRST
>   
>           The ``share`` boolean option is on by default with memfd.
>   
> +    ``-object iommufd,id=id[,fd=fd]``
> +        Creates an iommufd backend which allows control of DMA mapping
> +        through the ``/dev/iommu`` device.
> +
> +        The ``id`` parameter is a unique ID which frontends (such as
> +        vfio-pci of vdpa) will use to connect with the iommufd backend.
> +
> +        The ``fd`` parameter is an optional pre-opened file descriptor
> +        resulting from ``/dev/iommu`` opening. Usually the iommufd is shared
> +        across all subsystems, bringing the benefit of centralized
> +        reference counting.
> +
>       ``-object rng-builtin,id=id``
>           Creates a random number generator backend which obtains entropy
>           from QEMU builtin functions. The ``id`` parameter is a unique ID


