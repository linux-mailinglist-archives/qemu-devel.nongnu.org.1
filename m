Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC777D5C8
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2DW-0002XI-0L; Tue, 15 Aug 2023 18:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2DU-0002X2-4g
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2DR-0005M0-VI
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692137320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d6GkRoY0I4ERicGmObgiqt+p6enq9WSsGk+q8Qcz1t0=;
 b=L48cqMlb3DPDDA48ou9cVj7AareHT3VMAuANvRmkM0fkH7NusRCKyHoZpFZfDlkc6FxX0j
 Lms7qQ3plQQ2h0Au1GvJRQmg6r2pW9VtPnggnv5c1eeM2pVMcSgQgzrnBqjv6jZFcY6Lir
 g3nwJ53GmoZp3e9ZpvWBWmD5+uLEtSQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-zhTHGvKENTyakaA9YO3LuQ-1; Tue, 15 Aug 2023 18:08:39 -0400
X-MC-Unique: zhTHGvKENTyakaA9YO3LuQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a756945abeso1352394b6e.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692137318; x=1692742118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6GkRoY0I4ERicGmObgiqt+p6enq9WSsGk+q8Qcz1t0=;
 b=Hncu4xtwnM/tjhjjVbnE/fNn/SJPJzAUA+KMYdn5nGXe/DJsm6U3+T+Sk8wWM/mYY4
 pIfmmJzMXKnOee3qwrPsdAj+bLqVXo2blgWqrDYN0/7iKeeoXWvTB6F95fvs+Wan/zdL
 DRerRCq+Rqw89sg5a7PF68zQ0GGcOrqafT607hFaxWMkhYOkWlu5jMDlDOaTlGijajbL
 bkmBmyvPYFVmhHWafdcGJsEQdyx80jxtCwDN9QgyOHLDufjuNT7blnTNynLnQCjzdcGq
 AQCLbWSn+QEKQO287b1+3XYzZgyWcPJMLor19UzGSG4loYHgyH/zuYag4aFx6pu86L0e
 GXKA==
X-Gm-Message-State: AOJu0YxwSv9nAqqt4nnEIR7pJRr+JhxOkagUYfbqudJOAdszfpwvmwzU
 DTcy3LNXIoc/f4Pb3Fly6QaWJxy6qe/oggSHWccBM1EGtnakuQu5SkGFfQdVcA+iZeDfK0/91lN
 SkwouGtlyNgq4eVA=
X-Received: by 2002:a05:6358:9d93:b0:134:c407:681f with SMTP id
 d19-20020a0563589d9300b00134c407681fmr189314rwo.1.1692137318095; 
 Tue, 15 Aug 2023 15:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfnqYnmpk9ZFw614xm29/qkijwQiH4ZQ/lyUbCU4pLlveCr+PplLfRsVg9COWxqzouGPpZ4g==
X-Received: by 2002:a05:6358:9d93:b0:134:c407:681f with SMTP id
 d19-20020a0563589d9300b00134c407681fmr189295rwo.1.1692137317644; 
 Tue, 15 Aug 2023 15:08:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j22-20020ac874d6000000b004055d45e420sm4068210qtr.56.2023.08.15.15.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:08:37 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:08:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 09/10] migration: Be consistent about shutdown of
 source shared files
Message-ID: <ZNv3Yx1qn84V2dYJ@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

On Fri, Aug 11, 2023 at 12:08:35PM -0300, Fabiano Rosas wrote:
> When doing cleanup, we currently close() some of the shared migration
> files and shutdown() + close() others. Be consistent by always calling
> shutdown() before close().
> 
> Do this only for the source files for now because the source runs
> multiple threads which could cause races between the two calls. Having
> them together allows us to move them to a centralized place under the
> protection of a lock the next patch.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Logically I think we should only need shutdown() when we don't want to
close immediately, or can't for some reason..  Maybe instead of adding
shutdown()s, we can remove some?

> ---
>  migration/migration.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 7fec57ad7f..4df5ca25c1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1175,6 +1175,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>           * critical section won't block for long.
>           */
>          migration_ioc_unregister_yank_from_file(tmp);
> +        qemu_file_shutdown(tmp);
>          qemu_fclose(tmp);
>      }
>  
> @@ -1844,6 +1845,7 @@ static void migration_release_dst_files(MigrationState *ms)
>          ms->postcopy_qemufile_src = NULL;
>      }
>  
> +    qemu_file_shutdown(file);
>      qemu_fclose(file);
>  }
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


