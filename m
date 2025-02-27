Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4EA48B07
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Feb 2025 23:01:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnlvy-0007GU-Bj; Thu, 27 Feb 2025 17:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnlvf-0007Fu-8m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:00:27 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnlvd-0007Lt-4y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:00:27 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnlvO-000000007Ni-1hH6; Thu, 27 Feb 2025 23:00:10 +0100
Message-ID: <6546c3a4-bd81-42ea-88a2-b2f88ec2fbb3@maciej.szmigiero.name>
Date: Thu, 27 Feb 2025 23:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/36] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <b555ee5b753efbf2f7152f0692858802fc1bcb80.1739994627.git.maciej.szmigiero@oracle.com>
 <37865f56-cc4d-40ce-83ed-10e6d304ff01@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 xsFNBFpGusUBEADXUMM2t7y9sHhI79+2QUnDdpauIBjZDukPZArwD+sDlx5P+jxaZ13XjUQc
 6oJdk+jpvKiyzlbKqlDtw/Y2Ob24tg1g/zvkHn8AVUwX+ZWWewSZ0vcwp7u/LvA+w2nJbIL1
 N0/QUUdmxfkWTHhNqgkNX5hEmYqhwUPozFR0zblfD/6+XFR7VM9yT0fZPLqYLNOmGfqAXlxY
 m8nWmi+lxkd/PYqQQwOq6GQwxjRFEvSc09m/YPYo9hxh7a6s8hAP88YOf2PD8oBB1r5E7KGb
 Fv10Qss4CU/3zaiyRTExWwOJnTQdzSbtnM3S8/ZO/sL0FY/b4VLtlZzERAraxHdnPn8GgxYk
 oPtAqoyf52RkCabL9dsXPWYQjkwG8WEUPScHDy8Uoo6imQujshG23A99iPuXcWc/5ld9mIo/
 Ee7kN50MOXwS4vCJSv0cMkVhh77CmGUv5++E/rPcbXPLTPeRVy6SHgdDhIj7elmx2Lgo0cyh
 uyxyBKSuzPvb61nh5EKAGL7kPqflNw7LJkInzHqKHDNu57rVuCHEx4yxcKNB4pdE2SgyPxs9
 9W7Cz0q2Hd7Yu8GOXvMfQfrBiEV4q4PzidUtV6sLqVq0RMK7LEi0RiZpthwxz0IUFwRw2KS/
 9Kgs9LmOXYimodrV0pMxpVqcyTepmDSoWzyXNP2NL1+GuQtaTQARAQABzTBNYWNpZWogUy4g
 U3ptaWdpZXJvIDxtYWlsQG1hY2llai5zem1pZ2llcm8ubmFtZT7CwZQEEwEIAD4CGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZ7BxhgUJD0w7
 wQAKCRCEf143kM4JdwHlD/9Ef793d6Q3WkcapGZLg1hrUg+S3d1brtJSKP6B8Ny0tt/6kjc2
 M8q4v0pY6rA/tksIbBw6ZVZNCoce0w3/sy358jcDldh/eYotwUCHQzXl2IZwRT2SbmEoJn9J
 nAOnjMCpMFRyBC1yiWzOR3XonLFNB+kWfTK3fwzKWCmpcUkI5ANrmNiDFPcsn+TzfeMV/CzT
 FMsqVmr+TCWl29QB3U0eFZP8Y01UiowugS0jW/B/zWYbWo2FvoOqGLRUWgQ20NBXHlV5m0qa
 wI2Isrbos1kXSl2TDovT0Ppt+66RhV36SGA2qzLs0B9LO7/xqF4/xwmudkpabOoH5g3T20aH
 xlB0WuTJ7FyxZGnO6NL9QTxx3t86FfkKVfTksKP0FRKujsOxGQ1JpqdazyO6k7yMFfcnxwAb
 MyLU6ZepXf/6LvcFFe0oXC+ZNqj7kT6+hoTkZJcxynlcxSRzRSpnS41MRHJbyQM7kjpuVdyQ
 BWPdBnW0bYamlsW00w5XaR+fvNr4fV0vcqB991lxD4ayBbYPz11tnjlOwqnawH1ctCy5rdBY
 eTC6olpkmyUhrrIpTgEuxNU4GvnBK9oEEtNPC/x58AOxQuf1FhqbHYjz8D2Pyhso8TwS7NTa
 Z8b8o0vfsuqd3GPJKMiEhLEgu/io2KtLG10ynfh0vDBDQ7bwKoVlqC3It87AzQRaRrwiAQwA
 xnVmJqeP9VUTISps+WbyYFYlMFfIurl7tzK74bc67KUBp+PHuDP9p4ZcJUGC3UZJP85/GlUV
 dE1NairYWEJQUB7bpogTuzMI825QXIB9z842HwWfP2RW5eDtJMeujzJeFaUpmeTG9snzaYxY
 N3r0TDKj5dZwSIThIMQpsmhH2zylkT0jH7kBPxb8IkCQ1c6wgKITwoHFjTIO0B75U7bBNSDp
 XUaUDvd6T3xd1Fz57ujAvKHrZfWtaNSGwLmUYQAcFvrKDGPB5Z3ggkiTtkmW3OCQbnIxGJJw
 /+HefYhB5/kCcpKUQ2RYcYgCZ0/WcES1xU5dnNe4i0a5gsOFSOYCpNCfTHttVxKxZZTQ/rxj
 XwTuToXmTI4Nehn96t25DHZ0t9L9UEJ0yxH2y8Av4rtf75K2yAXFZa8dHnQgCkyjA/gs0ujG
 wD+Gs7dYQxP4i+rLhwBWD3mawJxLxY0vGwkG7k7npqanlsWlATHpOdqBMUiAR22hs02FikAo
 iXNgWTy7ABEBAAHCwXwEGAEIACYCGwwWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZ7BxrgUJ
 D0w6ggAKCRCEf143kM4Jd55ED/9M47pnUYDVoaa1Xu4dVHw2h0XhBS/svPqb80YtjcBVgRp0
 PxLkI6afwteLsjpDgr4QbjoF868ctjqs6p/M7+VkFJNSa4hPmCayU310zEawO4EYm+jPRUIJ
 i87pEmygoN4ZnXvOYA9lkkbbaJkYB+8rDFSYeeSjuez0qmISbzkRVBwhGXQG5s5Oyij2eJ7f
 OvtjExsYkLP3NqmsODWj9aXqWGYsHPa7NpcLvHtkhtc5+SjRRLzh/NWJUtgFkqNPfhGMNwE8
 IsgCYA1B0Wam1zwvVgn6yRcwaCycr/SxHZAR4zZQNGyV1CA+Ph3cMiL8s49RluhiAiDqbJDx
 voSNR7+hz6CXrAuFnUljMMWiSSeWDF+qSKVmUJIFHWW4s9RQofkF8/Bd6BZxIWQYxMKZm4S7
 dKo+5COEVOhSyYthhxNMCWDxLDuPoiGUbWBu/+8dXBusBV5fgcZ2SeQYnIvBzMj8NJ2vDU2D
 m/ajx6lQA/hW0zLYAew2v6WnHFnOXUlI3hv9LusUtj3XtLV2mf1FHvfYlrlI9WQsLiOE5nFN
 IsqJLm0TmM0i8WDnWovQHM8D0IzI/eUc4Ktbp0fVwWThP1ehdPEUKGCZflck5gvuU8yqE55r
 VrUwC3ocRUs4wXdUGZp67sExrfnb8QC2iXhYb+TpB8g7otkqYjL/nL8cQ8hdmg==
In-Reply-To: <37865f56-cc4d-40ce-83ed-10e6d304ff01@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 26.02.2025 18:46, Cédric Le Goater wrote:
> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Add support for VFIOMultifd data structure that will contain most of the
>> receive-side data together with its init/cleanup methods.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration-multifd.c   | 33 +++++++++++++++++++++++++++++++++
>>   hw/vfio/migration-multifd.h   |  8 ++++++++
>>   hw/vfio/migration.c           | 29 +++++++++++++++++++++++++++--
>>   include/hw/vfio/vfio-common.h |  3 +++
>>   4 files changed, 71 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 7328ad8e925c..c2defc0efef0 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -41,6 +41,9 @@ typedef struct VFIOStateBuffer {
>>       size_t len;
>>   } VFIOStateBuffer;
>> +typedef struct VFIOMultifd {
>> +} VFIOMultifd;
>> +
>>   static void vfio_state_buffer_clear(gpointer data)
>>   {
>>       VFIOStateBuffer *lb = data;
>> @@ -84,8 +87,38 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>>   }
>> +VFIOMultifd *vfio_multifd_new(void)
>> +{
>> +    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>> +
>> +    return multifd;
>> +}
>> +
>> +void vfio_multifd_free(VFIOMultifd *multifd)
>> +{
>> +    g_free(multifd);
>> +}
>> +
>>   bool vfio_multifd_transfer_supported(void)
>>   {
>>       return multifd_device_state_supported() &&
>>           migrate_send_switchover_start();
>>   }
>> +
>> +bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
>> +{
>> +    return false;
>> +}
>> +
>> +bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    if (vfio_multifd_transfer_enabled(vbasedev) &&
>> +        !vfio_multifd_transfer_supported()) {
>> +        error_setg(errp,
>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>> +                   vbasedev->name);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
>> index 8fe004c1da81..1eefba3b2eed 100644
>> --- a/hw/vfio/migration-multifd.h
>> +++ b/hw/vfio/migration-multifd.h
>> @@ -12,6 +12,14 @@
>>   #include "hw/vfio/vfio-common.h"
>> +typedef struct VFIOMultifd VFIOMultifd;
>> +
>> +VFIOMultifd *vfio_multifd_new(void);
>> +void vfio_multifd_free(VFIOMultifd *multifd);
>> +
>>   bool vfio_multifd_transfer_supported(void);
>> +bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>> +
>> +bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
>>   #endif
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 7b79be6ad293..4311de763885 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -674,15 +674,40 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    if (!vfio_multifd_transfer_setup(vbasedev, errp)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> +                                   migration->device_state, errp);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> -                                    vbasedev->migration->device_state, errp);
>> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
>> +        assert(!migration->multifd);
>> +        migration->multifd = vfio_multifd_new();
> 
> When called from vfio_load_setup(), I think vfio_multifd_transfer_setup()
> should allocate migration->multifd at the same time. It would simplify
> the setup to one step. Maybe we could add a bool parameter ? because,
> IIRC, you didn't like the idea of allocating it always, that is in
> vfio_save_setup() too.

I have added a "bool alloc_multifd" parameter to
vfio_multifd_transfer_setup() and renamed it to vfio_multifd_setup() for
consistency with vfio_multifd_cleanup().

Unexported vfio_multifd_new() now that it is called only from
vfio_multifd_setup() in the same translation unit.

> 
> For symmetry, could vfio_save_cleanup() call vfio_multifd_cleanup() too ?
> a setup implies a cleanup.

Added vfio_multifd_cleanup() call to vfio_save_cleanup() with a comment
describing that it is currently a NOP.

> Thanks,
> 
> C.

Thanks,
Maciej


