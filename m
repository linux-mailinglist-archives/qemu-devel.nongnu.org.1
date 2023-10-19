Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BB27CF687
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:20:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtR42-0002Fe-JO; Thu, 19 Oct 2023 07:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtR40-0002FJ-MW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtR3y-0006ll-Gw
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697714377;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xd84DT8fSkp6VaZHpErbpxYsp+GINSY+5iQSpGyFSQk=;
 b=WBwOxc41BXBvh7FltDY+dzgjHdZGouhb0kDuMfXjy1rGiDhKKyhqSxn0lR/MjjkE0bxlcV
 qdZ0/xOjRxevzYV93BoNO0vE7PkhUhC6fGlpb49oSJslrsZt38OsXVI7LgWfsL6cnP8qPm
 w9cAseb155i4cNGu0pvDf0THzyE1DLQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-ye9EZoEaMo-JjfQNmpD8-w-1; Thu, 19 Oct 2023 07:19:34 -0400
X-MC-Unique: ye9EZoEaMo-JjfQNmpD8-w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d933caa8eso3928405f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697714372; x=1698319172;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xd84DT8fSkp6VaZHpErbpxYsp+GINSY+5iQSpGyFSQk=;
 b=c8Yi/dKSWtEl2JQlMN4ZfZh+Yj2mBNHqoTPSuxwxq9tUs5WoVO0XMjRc08NN6GVHio
 cvgeIka6SOeOMCD/t2TLd3FPyotU6pUM7Ov3dpOVETGZL3L6G61Klpuz+I+SWz+v6FkJ
 YzVXAsiT53qdAwuClO5LEF6Q/SO1pZkLQLc6LefitW2FcC3VW2aFCdjzGYj+ICdIXSgF
 RPEU18kfoUSo4SXywIyMEbJ/+ld3dmRM8JunJ0jz3sbR9yQBThDoQ/EZ+0vSl4wydp5a
 xuSSkIfMshB4u5EINLVM7I7jwlbn+ZZeJbu3ftIpkrORDFu4Yuvsgb1fiHPsWbPNk46y
 ScRA==
X-Gm-Message-State: AOJu0YxipguzOpNzlvmwNc1l8aBo6yZXIhwBzfoY2l+L1q3NfgS8crqe
 clNJgNLi32v6DhCbgeRVQh3/vcqPdfHpolIy7dRO+fCLqLendunvdrdet1CE8q/mZ2KNERcaWfJ
 IPRtpj1zC5O3BvRU=
X-Received: by 2002:a5d:4d12:0:b0:32d:a57b:8c8d with SMTP id
 z18-20020a5d4d12000000b0032da57b8c8dmr1328064wrt.69.1697714371940; 
 Thu, 19 Oct 2023 04:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUU7trc46slJSnJvVTC26z3kxLtJf4xDRWVz49KTwXD7D9+TnbrBz3BJ6bgIjybqgiife0bg==
X-Received: by 2002:a5d:4d12:0:b0:32d:a57b:8c8d with SMTP id
 z18-20020a5d4d12000000b0032da57b8c8dmr1328052wrt.69.1697714371564; 
 Thu, 19 Oct 2023 04:19:31 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q7-20020adffec7000000b0031980294e9fsm4245339wrs.116.2023.10.19.04.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:19:31 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org,  nanhai.zou@intel.com
Subject: Re: [PATCH 3/5] ram compress: Refactor ram compression functions
In-Reply-To: <20231018221224.599065-4-yuan1.liu@intel.com> (Yuan Liu's message
 of "Thu, 19 Oct 2023 06:12:22 +0800")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <20231018221224.599065-4-yuan1.liu@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:19:30 +0200
Message-ID: <87pm1a6erh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Yuan Liu <yuan1.liu@intel.com> wrote:
> Refactor legacy RAM compression functions to support both IAA
> compression and CPU compression.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>

Cmopression code is declared obsolete (see patches on list).
I don't think it is a good idea that you put things there.

And here you are doing two things:

- change several functions prefix from compress_threads to ram_compress
- Adding several hooks where you can add the iaa acceleration

Please, split in two different patches:
- rename/create new functions
- put the migrate_compress_with_iaa() hooks

Later, Juan.

> ---
>  migration/migration.c    |  6 +--
>  migration/ram-compress.c | 81 ++++++++++++++++++++++++++++++++--------
>  migration/ram-compress.h | 10 ++---
>  migration/ram.c          | 18 ++++++---
>  4 files changed, 86 insertions(+), 29 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 585d3c8f55..08a9c313d0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -237,7 +237,7 @@ void migration_incoming_state_destroy(void)
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      multifd_load_cleanup();
> -    compress_threads_load_cleanup();
> +    ram_compress_load_cleanup();
>  
>      if (mis->to_src_file) {
>          /* Tell source that we are done */
> @@ -524,7 +524,7 @@ process_incoming_migration_co(void *opaque)
>  
>      assert(mis->from_src_file);
>  
> -    if (compress_threads_load_setup(mis->from_src_file)) {
> +    if (ram_compress_load_setup(mis->from_src_file)) {
>          error_report("Failed to setup decompress threads");
>          goto fail;
>      }
> @@ -577,7 +577,7 @@ fail:
>      qemu_fclose(mis->from_src_file);
>  
>      multifd_load_cleanup();
> -    compress_threads_load_cleanup();
> +    ram_compress_load_cleanup();
>  
>      exit(EXIT_FAILURE);
>  }
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index 06254d8c69..47357352f7 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -105,11 +105,11 @@ static void *do_data_compress(void *opaque)
>      return NULL;
>  }
>  
> -void compress_threads_save_cleanup(void)
> +static void compress_threads_save_cleanup(void)
>  {
>      int i, thread_count;
>  
> -    if (!migrate_compress() || !comp_param) {
> +    if (!comp_param) {
>          return;
>      }
>  
> @@ -144,13 +144,10 @@ void compress_threads_save_cleanup(void)
>      comp_param = NULL;
>  }
>  
> -int compress_threads_save_setup(void)
> +static int compress_threads_save_setup(void)
>  {
>      int i, thread_count;
>  
> -    if (!migrate_compress()) {
> -        return 0;
> -    }
>      thread_count = migrate_compress_threads();
>      compress_threads = g_new0(QemuThread, thread_count);
>      comp_param = g_new0(CompressParam, thread_count);
> @@ -370,6 +367,11 @@ int wait_for_decompress_done(void)
>          return 0;
>      }
>  
> +    if (migrate_compress_with_iaa()) {
> +        /* Implement in next patch */
> +        return 0;
> +    }
> +
>      thread_count = migrate_decompress_threads();
>      qemu_mutex_lock(&decomp_done_lock);
>      for (idx = 0; idx < thread_count; idx++) {
> @@ -381,13 +383,10 @@ int wait_for_decompress_done(void)
>      return qemu_file_get_error(decomp_file);
>  }
>  
> -void compress_threads_load_cleanup(void)
> +static void compress_threads_load_cleanup(void)
>  {
>      int i, thread_count;
>  
> -    if (!migrate_compress()) {
> -        return;
> -    }
>      thread_count = migrate_decompress_threads();
>      for (i = 0; i < thread_count; i++) {
>          /*
> @@ -422,14 +421,10 @@ void compress_threads_load_cleanup(void)
>      decomp_file = NULL;
>  }
>  
> -int compress_threads_load_setup(QEMUFile *f)
> +static int compress_threads_load_setup(QEMUFile *f)
>  {
>      int i, thread_count;
>  
> -    if (!migrate_compress()) {
> -        return 0;
> -    }
> -
>      thread_count = migrate_decompress_threads();
>      decompress_threads = g_new0(QemuThread, thread_count);
>      decomp_param = g_new0(DecompressParam, thread_count);
> @@ -457,7 +452,7 @@ exit:
>      return -1;
>  }
>  
> -void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
> +static void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
>  {
>      int idx, thread_count;
>  
> @@ -483,3 +478,57 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
>          }
>      }
>  }
> +
> +int ram_compress_save_setup(void)
> +{
> +    if (!migrate_compress()) {
> +        return 0;
> +    }
> +    if (migrate_compress_with_iaa()) {
> +        /* Implement in next patch */
> +        return 0;
> +    }
> +    return compress_threads_save_setup();
> +}
> +
> +void ram_compress_save_cleanup(void)
> +{
> +    if (!migrate_compress()) {
> +        return;
> +    }
> +    if (migrate_compress_with_iaa()) {
> +        /* Implement in next patch */
> +        return;
> +    }
> +    compress_threads_save_cleanup();
> +}
> +
> +void ram_decompress_data(QEMUFile *f, void *host, int len)
> +{
> +    if (migrate_compress_with_iaa()) {
> +        /* Implement in next patch */
> +    }
> +    decompress_data_with_multi_threads(f, host, len);
> +}
> +
> +int ram_compress_load_setup(QEMUFile *f)
> +{
> +    if (!migrate_compress()) {
> +        return 0;
> +    }
> +    if (migrate_compress_with_iaa()) {
> +        /* Implement in next patch */
> +    }
> +    return compress_threads_load_setup(f);
> +}
> +
> +void ram_compress_load_cleanup(void)
> +{
> +    if (!migrate_compress()) {
> +        return;
> +    }
> +    if (migrate_compress_with_iaa()) {
> +        /* Implement in next patch */
> +    }
> +    compress_threads_load_cleanup();
> +}
> diff --git a/migration/ram-compress.h b/migration/ram-compress.h
> index 6f7fe2f472..382083acf6 100644
> --- a/migration/ram-compress.h
> +++ b/migration/ram-compress.h
> @@ -55,16 +55,16 @@ struct CompressParam {
>  };
>  typedef struct CompressParam CompressParam;
>  
> -void compress_threads_save_cleanup(void);
> -int compress_threads_save_setup(void);
> +void ram_compress_save_cleanup(void);
> +int ram_compress_save_setup(void);
>  
>  void flush_compressed_data(int (send_queued_data(CompressParam *)));
>  int compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
>                                  int (send_queued_data(CompressParam *)));
>  
>  int wait_for_decompress_done(void);
> -void compress_threads_load_cleanup(void);
> -int compress_threads_load_setup(QEMUFile *f);
> -void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
> +void ram_compress_load_cleanup(void);
> +int ram_compress_load_setup(QEMUFile *f);
> +void ram_decompress_data(QEMUFile *f, void *host, int len);
>  
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index e4bfd39f08..34ee1de332 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1347,6 +1347,10 @@ static void ram_flush_compressed_data(RAMState *rs)
>      if (!save_page_use_compression(rs)) {
>          return;
>      }
> +    if (migrate_compress_with_iaa()) {
> +        /* Implement in next patch */
> +        return;
> +    }
>  
>      flush_compressed_data(send_queued_data);
>  }
> @@ -2099,6 +2103,10 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
>          return false;
>      }
>  
> +    if (migrate_compress_with_iaa()) {
> +        /* Implement in next patch */
> +        return true;
> +    }
>      if (compress_page_with_multi_thread(block, offset, send_queued_data) > 0) {
>          return true;
>      }
> @@ -2498,7 +2506,7 @@ static void ram_save_cleanup(void *opaque)
>      }
>  
>      xbzrle_cleanup();
> -    compress_threads_save_cleanup();
> +    ram_compress_save_cleanup();
>      ram_state_cleanup(rsp);
>      g_free(migration_ops);
>      migration_ops = NULL;
> @@ -3023,14 +3031,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      RAMBlock *block;
>      int ret;
>  
> -    if (compress_threads_save_setup()) {
> +    if (ram_compress_save_setup()) {
>          return -1;
>      }
>  
>      /* migration has already setup the bitmap, reuse it. */
>      if (!migration_in_colo_state()) {
>          if (ram_init_all(rsp) != 0) {
> -            compress_threads_save_cleanup();
> +            ram_compress_save_cleanup();
>              return -1;
>          }
>      }
> @@ -3753,7 +3761,7 @@ int ram_load_postcopy(QEMUFile *f, int channel)
>                  ret = -EINVAL;
>                  break;
>              }
> -            decompress_data_with_multi_threads(f, page_buffer, len);
> +            ram_decompress_data(f, page_buffer, len);
>              break;
>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
>              multifd_recv_sync_main();
> @@ -4022,7 +4030,7 @@ static int ram_load_precopy(QEMUFile *f)
>                  ret = -EINVAL;
>                  break;
>              }
> -            decompress_data_with_multi_threads(f, host, len);
> +            ram_decompress_data(f, host, len);
>              break;
>  
>          case RAM_SAVE_FLAG_XBZRLE:


