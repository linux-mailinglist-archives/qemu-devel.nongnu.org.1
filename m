Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D96077BBC28
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:53:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qon7n-0001xe-Sl; Fri, 06 Oct 2023 11:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qon7h-0001xP-IG
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 11:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qon7f-0006B6-Cy
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 11:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696607534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ornt6UQuswj4ZIjVskWVreXOcasbAfv2tlZr2wL/I5Q=;
 b=FlndV/yefEaJCgVLa39OIErhnuTdmuaL+mpKcZw6acgz51rE2IQfJPb5SsRUuBLK69+RgJ
 PjpMVcncNaTTqv70gHh2RiHyKekd7WFmrcYnPI/3NlbKiGziVe7x1/8sgOp0KLMRKnFoW4
 VAe4t5VrWlC3YRTqizvtZGxUsR/pzA0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-3E4mBGwbNTy3OhFBkfxoDA-1; Fri, 06 Oct 2023 11:52:12 -0400
X-MC-Unique: 3E4mBGwbNTy3OhFBkfxoDA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4197878ffe9so6318281cf.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 08:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696607532; x=1697212332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ornt6UQuswj4ZIjVskWVreXOcasbAfv2tlZr2wL/I5Q=;
 b=NgK5vxzybnthjsvrBJE/Y5NunC2nRx1JyDxduz1woWF5gmr49nmo8n9uFurIn4awCs
 OZGROjMPyA0ahXec7r6L/dYWMGhhqFNzbvZfi2xgGz8EbrbleIRXGYFQSUZMnMTCq1ki
 Oab4p/HRvsEwMpiIkGHpyuuYYaWE2nosG1897mIhPOs8zwgfpVhLTnqWa0nf+Uwzd8+i
 DPFfbKtnPPZ7tqmXQ2vjEJXlpaefcfMVvO5VjXCzJfZHQH+tmgaJjVkDHZX9jo883Zl/
 eXVOYpkf6FHoQ2zQbQxTSx9OlXHeAtYPwxWsT3mMdLVhsUVBzM0d0nddBWrm/TraYuWp
 mJig==
X-Gm-Message-State: AOJu0YzJxp99md51+fxVxJ5VO+whXgtWjzfaG4VUnrLuUiSx33Z0T99b
 HwofjIh6/jzlFqrGeQwvt5KMfEZHuJarBIZID5uPU3orQvDN0rYlsQDrXHwvMI72QU+Khm8Wc3b
 7DDBoJbbBQJ7Wr+g=
X-Received: by 2002:a05:622a:20e:b0:3ff:2a6b:5a76 with SMTP id
 b14-20020a05622a020e00b003ff2a6b5a76mr9257371qtx.5.1696607532231; 
 Fri, 06 Oct 2023 08:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkcNs30FP90aucokOXbVlg5wD/WnHxDGALUVDzmgQAYvRSOb1IEQhVeyhODcXF13wPJcUMcQ==
X-Received: by 2002:a05:622a:20e:b0:3ff:2a6b:5a76 with SMTP id
 b14-20020a05622a020e00b003ff2a6b5a76mr9257352qtx.5.1696607531916; 
 Fri, 06 Oct 2023 08:52:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j1-20020ac84c81000000b0041812703b7esm1367607qtv.52.2023.10.06.08.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 08:52:11 -0700 (PDT)
Date: Fri, 6 Oct 2023 11:52:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>, leobras@redhat.com,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/2] migration: Fix rdma migration failed
Message-ID: <ZSAtKmOFkomgXyJ7@x1n>
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
 <87edib5ybg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edib5ybg.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Oct 03, 2023 at 08:57:07PM +0200, Juan Quintela wrote:
> commit c638f66121ce30063fbf68c3eab4d7429cf2b209
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Tue Oct 3 20:53:38 2023 +0200
> 
>     migration: Non multifd migration don't care about multifd flushes
>     
>     RDMA was having trouble because
>     migrate_multifd_flush_after_each_section() can only be true or false,
>     but we don't want to send any flush when we are not in multifd
>     migration.
>     
>     CC: Fabiano Rosas <farosas@suse.de
>     Reported-by: Li Zhijian <lizhijian@fujitsu.com>
>     Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index e4bfd39f08..716cef6425 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1387,7 +1387,8 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (!migrate_multifd_flush_after_each_section()) {
> +            if (migrate_multifd() &&
> +                !migrate_multifd_flush_after_each_section()) {
>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>                  int ret = multifd_send_sync_main(f);
>                  if (ret < 0) {
> @@ -3064,7 +3065,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>          return ret;
>      }
>  
> -    if (!migrate_multifd_flush_after_each_section()) {
> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>      }
>  
> @@ -3176,7 +3177,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  out:
>      if (ret >= 0
>          && migration_is_setup_or_active(migrate_get_current()->state)) {
> -        if (migrate_multifd_flush_after_each_section()) {
> +        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
>              ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
>              if (ret < 0) {
>                  return ret;
> @@ -3253,7 +3254,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          return ret;
>      }
>  
> -    if (!migrate_multifd_flush_after_each_section()) {
> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>      }
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> @@ -3760,7 +3761,7 @@ int ram_load_postcopy(QEMUFile *f, int channel)
>              break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
> -            if (migrate_multifd_flush_after_each_section()) {
> +            if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
>                  multifd_recv_sync_main();
>              }
>              break;
> @@ -4038,7 +4039,8 @@ static int ram_load_precopy(QEMUFile *f)
>              break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
> -            if (migrate_multifd_flush_after_each_section()) {
> +            if (migrate_multifd() &&
> +                migrate_multifd_flush_after_each_section()) {
>                  multifd_recv_sync_main();
>              }
>              break;

Reviewed-by: Peter Xu <peterx@redhat.com>

Did you forget to send this out formally?  Even if f1de309792d6656e landed
(which, IMHO, shouldn't..), but IIUC rdma is still broken..

Thanks,

-- 
Peter Xu


