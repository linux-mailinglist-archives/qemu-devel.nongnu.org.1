Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DDD70D100
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:17:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1HYs-0007AE-NE; Mon, 22 May 2023 22:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q1HYg-00079b-8e
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q1HYd-0006a7-5y
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684808126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6uMaS4bDBH4SJJzRIjdW5hHe0z5D7FLQL/9azT/ejI=;
 b=MLIaDeeRie44BbQGipfGpgHJQlY3l3xRCuMU3a9ay4z2p9VRj9+eQrvVg/vqeG1nWHd8k3
 QO9a03L31i2ce0PJw+fc7xpX5IsbW9B12zTH/DcYJv1C+cyRAUUicFaiN/xyOeUqOEhjil
 dn7JNlW8o/CxFEChPvdtyQdKb1nxUBg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-myhdGrEGPWepR1EC_MktMQ-1; Mon, 22 May 2023 22:15:25 -0400
X-MC-Unique: myhdGrEGPWepR1EC_MktMQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6ab25f20f9aso1874105a34.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684808124; x=1687400124;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u6uMaS4bDBH4SJJzRIjdW5hHe0z5D7FLQL/9azT/ejI=;
 b=IBoeRf4LdWdytl0YwB7MO7x6DriQyqTi4sXt/5ok4kqtkA5S1f9PeLDvg31wB414xn
 PHGTZEetkfrTenCfk6u+eWAzgNBPUAbDDrDOEGBAWpuJviPV8G02SrIHIHVKrUxUD3PJ
 ozlU8zRwualFs8BrW+aJ5TvNmJhGN2AzRCDnuzQQ5YtnGrGPmspuFFxV2qoRt8AgKeP+
 57kcubswYxsvGS/UyUTkDDMb35QW2MFsn54tfT2MjupvXgljcCxBcvJ5NsireNPFCFAA
 ienJq37UC0Ez3l5KYU0fSEYm9ssf+Wvd64n3DBJLQF/dW5PntQZixZfRF5LVbBMdnb2/
 CZlg==
X-Gm-Message-State: AC+VfDwWjzM/uez8Erm+FZst9TvCbtep5pVCd0/4MEyvmdm7dCAm4/AI
 JST5SFaQkODPs/vdkpV+HR1bs6T2TMqqVnHvyf94ym2zotMUzLF2fGGrvQL4GKS3uneXO+cQpLo
 eUS3UNCNBLNEB7DE=
X-Received: by 2002:a05:6808:b0b:b0:398:1849:ea55 with SMTP id
 s11-20020a0568080b0b00b003981849ea55mr1659747oij.50.1684808124401; 
 Mon, 22 May 2023 19:15:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6T2Z6bs5L1Z9wiDlRUVXH/Nxx8gy25kjilEhCNR4LX8a9eAeY0cT392CaezhFKyz7/rIM/rw==
X-Received: by 2002:a05:6808:b0b:b0:398:1849:ea55 with SMTP id
 s11-20020a0568080b0b00b003981849ea55mr1659726oij.50.1684808124131; 
 Mon, 22 May 2023 19:15:24 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 w9-20020aca6209000000b0038cabfcb3ccsm3410631oib.15.2023.05.22.19.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:15:23 -0700 (PDT)
Message-ID: <1e3a3735a5ba81abb562e8f6c21ab33f38992af5.camel@redhat.com>
Subject: Re: [PATCH v2 02/16] migration: Correct transferred bytes value
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>, 
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John Snow
 <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,  =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Date: Mon, 22 May 2023 23:15:16 -0300
In-Reply-To: <20230515195709.63843-3-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-3-quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leobras@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 2023-05-15 at 21:56 +0200, Juan Quintela wrote:
> We forget several places to add to trasferred amount of data.  With
> this fixes I get:
>=20
>    qemu_file_transferred() + multifd_bytes =3D=3D transferred
>=20
> The only place whrer this is not true is during devices sending.  But
> going all through the full tree searching for devices that use
> QEMUFile directly is a bit too much.
>=20
> Multifd, precopy and xbzrle work as expected. Postocpy still misses 35
> bytes, but searching for them is getting complicated, so I stop here.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c       | 14 ++++++++++++++
>  migration/savevm.c    | 19 +++++++++++++++++--
>  migration/vmstate.c   |  3 +++
>  migration/meson.build |  2 +-
>  4 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index f69d8d42b0..fd5a8db0f8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -337,6 +337,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
> =20
>      g_free(le_bitmap);
> =20
> +    stat64_add(&mig_stats.transferred, 8 + size + 8);
>      if (qemu_file_get_error(file)) {
>          return qemu_file_get_error(file);
>      }
> @@ -1392,6 +1393,7 @@ static int find_dirty_block(RAMState *rs, PageSearc=
hStatus *pss)
>                      return ret;
>                  }
>                  qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +                stat64_add(&mig_stats.transferred, 8);
>                  qemu_fflush(f);
>              }
>              /*
> @@ -3020,6 +3022,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
>      RAMState **rsp =3D opaque;
>      RAMBlock *block;
>      int ret;
> +    size_t size =3D 0;
> =20
>      if (compress_threads_save_setup()) {
>          return -1;
> @@ -3038,16 +3041,20 @@ static int ram_save_setup(QEMUFile *f, void *opaq=
ue)
>          qemu_put_be64(f, ram_bytes_total_with_ignored()
>                           | RAM_SAVE_FLAG_MEM_SIZE);
> =20
> +        size +=3D 8;
>          RAMBLOCK_FOREACH_MIGRATABLE(block) {
>              qemu_put_byte(f, strlen(block->idstr));
>              qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->id=
str));
>              qemu_put_be64(f, block->used_length);
> +            size +=3D 1 + strlen(block->idstr) + 8;

I was thinking some of them would look better with sizeof()s instead of giv=
en
literal number, such as:

size +=3D sizeof(Byte) + strlen(block->idstr) + sizeof(block->used_length);

Maybe too much?

>              if (migrate_postcopy_ram() && block->page_size !=3D
>                                            qemu_host_page_size) {
>                  qemu_put_be64(f, block->page_size);
> +                size +=3D 8;
>              }
>              if (migrate_ignore_shared()) {
>                  qemu_put_be64(f, block->mr->addr);
> +                size +=3D 8;
>              }
>          }
>      }
> @@ -3064,11 +3071,14 @@ static int ram_save_setup(QEMUFile *f, void *opaq=
ue)
> =20
>      if (!migrate_multifd_flush_after_each_section()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +        size +=3D 8;

sizeof(uint64_t) here is probably too much.


Maybe, it would be nice to have qemu_put_* to return the value, and in this
case:

size +=3D qemu_put_be64(...)

What do you think?

Anyway,=20

Reviewed-by: Leonardo Bras <leobras@redhat.com>

>      }
> =20
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    size +=3D 8;
>      qemu_fflush(f);
> =20
> +    stat64_add(&mig_stats.transferred, size);
>      return 0;
>  }
> =20
> @@ -3209,6 +3219,7 @@ static int ram_save_complete(QEMUFile *f, void *opa=
que)
>      RAMState **temp =3D opaque;
>      RAMState *rs =3D *temp;
>      int ret =3D 0;
> +    size_t size =3D 0;
> =20
>      rs->last_stage =3D !migration_in_colo_state();
> =20
> @@ -3253,8 +3264,11 @@ static int ram_save_complete(QEMUFile *f, void *op=
aque)
> =20
>      if (!migrate_multifd_flush_after_each_section()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +        size +=3D 8;
>      }
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    size +=3D 8;
> +    stat64_add(&mig_stats.transferred, size);
>      qemu_fflush(f);
> =20
>      return 0;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e33788343a..c7af9050c2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -952,6 +952,7 @@ static void save_section_header(QEMUFile *f, SaveStat=
eEntry *se,
>      qemu_put_byte(f, section_type);
>      qemu_put_be32(f, se->section_id);
> =20
> +    size_t size =3D 1 + 4;
>      if (section_type =3D=3D QEMU_VM_SECTION_FULL ||
>          section_type =3D=3D QEMU_VM_SECTION_START) {
>          /* ID string */
> @@ -961,7 +962,9 @@ static void save_section_header(QEMUFile *f, SaveStat=
eEntry *se,
> =20
>          qemu_put_be32(f, se->instance_id);
>          qemu_put_be32(f, se->version_id);
> +        size +=3D 1 + len + 4 + 4;
>      }
> +    stat64_add(&mig_stats.transferred, size);
>  }
> =20
>  /*
> @@ -973,6 +976,7 @@ static void save_section_footer(QEMUFile *f, SaveStat=
eEntry *se)
>      if (migrate_get_current()->send_section_footer) {
>          qemu_put_byte(f, QEMU_VM_SECTION_FOOTER);
>          qemu_put_be32(f, se->section_id);
> +        stat64_add(&mig_stats.transferred, 1 + 4);
>      }
>  }
> =20
> @@ -1032,6 +1036,7 @@ static void qemu_savevm_command_send(QEMUFile *f,
>      qemu_put_be16(f, (uint16_t)command);
>      qemu_put_be16(f, len);
>      qemu_put_buffer(f, data, len);
> +    stat64_add(&mig_stats.transferred, 1 + 2 + 2 + len);
>      qemu_fflush(f);
>  }
> =20
> @@ -1212,11 +1217,13 @@ void qemu_savevm_state_header(QEMUFile *f)
>      trace_savevm_state_header();
>      qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>      qemu_put_be32(f, QEMU_VM_FILE_VERSION);
> -
> +    size_t size =3D 4 + 4;
>      if (migrate_get_current()->send_configuration) {
>          qemu_put_byte(f, QEMU_VM_CONFIGURATION);
> +        size +=3D 1;
>          vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
>      }
> +    stat64_add(&mig_stats.transferred, size);
>  }
> =20
>  bool qemu_savevm_state_guest_unplug_pending(void)
> @@ -1384,6 +1391,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *=
f)
>  {
>      SaveStateEntry *se;
>      int ret;
> +    size_t size =3D 0;
> =20
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (!se->ops || !se->ops->save_live_complete_postcopy) {
> @@ -1398,7 +1406,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *=
f)
>          /* Section type */
>          qemu_put_byte(f, QEMU_VM_SECTION_END);
>          qemu_put_be32(f, se->section_id);
> -
> +        size +=3D 1 + 4;
>          ret =3D se->ops->save_live_complete_postcopy(f, se->opaque);
>          trace_savevm_section_end(se->idstr, se->section_id, ret);
>          save_section_footer(f, se);
> @@ -1409,6 +1417,8 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *=
f)
>      }
> =20
>      qemu_put_byte(f, QEMU_VM_EOF);
> +    size +=3D 1;
> +    stat64_add(&mig_stats.transferred, size);
>      qemu_fflush(f);
>  }
> =20
> @@ -1484,6 +1494,7 @@ int qemu_savevm_state_complete_precopy_non_iterable=
(QEMUFile *f,
>      if (!in_postcopy) {
>          /* Postcopy stream will still be going */
>          qemu_put_byte(f, QEMU_VM_EOF);
> +        stat64_add(&mig_stats.transferred, 1);
>      }
> =20
>      json_writer_end_array(vmdesc);
> @@ -1664,15 +1675,18 @@ void qemu_savevm_live_state(QEMUFile *f)
>      /* save QEMU_VM_SECTION_END section */
>      qemu_savevm_state_complete_precopy(f, true, false);
>      qemu_put_byte(f, QEMU_VM_EOF);
> +    stat64_add(&mig_stats.transferred, 1);
>  }
> =20
>  int qemu_save_device_state(QEMUFile *f)
>  {
>      SaveStateEntry *se;
> +    size_t size =3D 0;
> =20
>      if (!migration_in_colo_state()) {
>          qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>          qemu_put_be32(f, QEMU_VM_FILE_VERSION);
> +        size =3D 4 + 4;
>      }
>      cpu_synchronize_all_states();
> =20
> @@ -1690,6 +1704,7 @@ int qemu_save_device_state(QEMUFile *f)
> =20
>      qemu_put_byte(f, QEMU_VM_EOF);
> =20
> +    stat64_add(&mig_stats.transferred, size + 1);
>      return qemu_file_get_error(f);
>  }
> =20
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index af01d54b6f..ee3b70a6a8 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -12,6 +12,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "migration.h"
> +#include "migration-stats.h"
>  #include "migration/vmstate.h"
>  #include "savevm.h"
>  #include "qapi/qmp/json-writer.h"
> @@ -394,6 +395,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDe=
scription *vmsd,
>                  written_bytes =3D qemu_file_transferred_fast(f) - old_of=
fset;
>                  vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_by=
tes, i);
> =20
> +                stat64_add(&mig_stats.transferred, written_bytes);
>                  /* Compressed arrays only care about the first element *=
/
>                  if (vmdesc_loop && vmsd_can_compress(field)) {
>                      vmdesc_loop =3D NULL;
> @@ -517,6 +519,7 @@ static int vmstate_subsection_save(QEMUFile *f, const=
 VMStateDescription *vmsd,
>              qemu_put_byte(f, len);
>              qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
>              qemu_put_be32(f, vmsdsub->version_id);
> +            stat64_add(&mig_stats.transferred, 1 + 1 + len + 4);
>              ret =3D vmstate_save_state(f, vmsdsub, opaque, vmdesc);
>              if (ret) {
>                  return ret;
> diff --git a/migration/meson.build b/migration/meson.build
> index dc8b1daef5..b3d0c537c8 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -1,5 +1,6 @@
>  # Files needed by unit tests
>  migration_files =3D files(
> +  'migration-stats.c',
>    'page_cache.c',
>    'xbzrle.c',
>    'vmstate-types.c',
> @@ -18,7 +19,6 @@ softmmu_ss.add(files(
>    'fd.c',
>    'global_state.c',
>    'migration-hmp-cmds.c',
> -  'migration-stats.c',
>    'migration.c',
>    'multifd.c',
>    'multifd-zlib.c',


