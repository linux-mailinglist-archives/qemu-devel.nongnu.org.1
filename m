Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC777D5D3
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2K9-0004SO-C0; Tue, 15 Aug 2023 18:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2K7-0004SF-5f
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2K4-00071J-7e
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692137730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9zbj8oUpT1Yh31DRWrHOg5Z5lQ3rld2qJFFqn6kLjC0=;
 b=PhA58uVjrh0geJxzEMAZWWHljoyeSNnGg1IlcMUmxML3jMjUUxqoF+RfebJEGPzMIwEUfE
 PaTxVaVesOiCcOlMGFwsvVmMsH/gP0/Ue/eZQkQwmqOeVMQa52JKegYPhTs69fC1Uw/AC7
 I58/qKUK/nOpg/JsC53mfTSnTrRLYEM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-2xDdddNeN2a1lr3LoDqaqg-1; Tue, 15 Aug 2023 18:15:29 -0400
X-MC-Unique: 2xDdddNeN2a1lr3LoDqaqg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63d2b88325bso16546326d6.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692137728; x=1692742528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zbj8oUpT1Yh31DRWrHOg5Z5lQ3rld2qJFFqn6kLjC0=;
 b=GtK1anjiy9l0L7PuIS1harkAzej1IdvXcFJFQetKG5kI5xGtIrbgHCBNO098/8sFVb
 4UYRsM/AdFYTIaf8ZOGLKDOQ+1ma+drKnGM7h3bxbA/xlonqbv6PR15QgeyaihFQLHGH
 c+tECqWjjKkPcbp+4IxJLHuzU5/bSpyU1U/jiXyrlJKLoVUqMdw54X+8ShralMdjq/Ep
 /g7e3SdPjZPb15+amVYUc3CU21NewLJP9uUvF7bCPDfc5IDf8hf77W/0xB6LoAnqSqeE
 yz1p+ZwKoMmdAxxvm+XBKYrIRcmm+6gWSvf077pRVj5hPLJYX66batQDw9FbkST4r4ya
 DUAg==
X-Gm-Message-State: AOJu0YxuNUIHMDc9YALxGRMADdd99jijKrjcBIrGaU68nfmluchNYMnw
 pOZ9D8z5A29NSN2Y/xQgtEkpyeNeABnnKjsGH7HOr2xZJdKXLK76RVX2/hroudUIaFsVKDOWY71
 dyaAkPWzd6hR+xbUHcpLgW8c=
X-Received: by 2002:a05:6214:242e:b0:62b:6c6f:b3e3 with SMTP id
 gy14-20020a056214242e00b0062b6c6fb3e3mr74812qvb.3.1692137728708; 
 Tue, 15 Aug 2023 15:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMXi15P5mpSn/wm+0H3AS5J5+U1S5G+r0k4wi0HrzFRQEEnQMg03qrc42Yl5Luh2ESO5U/Pw==
X-Received: by 2002:a05:6214:242e:b0:62b:6c6f:b3e3 with SMTP id
 gy14-20020a056214242e00b0062b6c6fb3e3mr74798qvb.3.1692137728485; 
 Tue, 15 Aug 2023 15:15:28 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t12-20020a0cde0c000000b0062fffa42cc5sm4419447qvk.79.2023.08.15.15.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:15:28 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:15:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 10/10] migration: Add a wrapper to cleanup migration
 files
Message-ID: <ZNv4/ndxGPpaIX9H@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Aug 11, 2023 at 12:08:36PM -0300, Fabiano Rosas wrote:
> We currently have a pattern for cleaning up a migration QEMUFile:
> 
>   qemu_mutex_lock(&s->qemu_file_lock);
>   file = s->file_name;
>   s->file_name = NULL;
>   qemu_mutex_unlock(&s->qemu_file_lock);
> 
>   migration_ioc_unregister_yank_from_file(file);
>   qemu_file_shutdown(file);
>   qemu_fclose(file);
> 
> There are some considerations for this sequence:
> 
> - we must clear the pointer under the lock, to avoid TOC/TOU bugs;
> - the shutdown() and close() expect be given a non-null parameter;
> - a close() in one thread should not race with a shutdown() in another;
> 
> Create a wrapper function to make sure everything works correctly.
> 
> Note: the return path did not used to call
>       migration_ioc_unregister_yank_from_file(), but I added it
>       nonetheless for uniformity.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

This definitely looks cleaner.  Probably can be squashed together with
previous patch?  If you could double check whether we can just drop the
shutdown() all over the places when close() altogether, it'll be even
nicer (I hope I didn't miss any real reasons to explicitly do that).

> diff --git a/util/yank.c b/util/yank.c
> index abf47c346d..4b6afbf589 100644
> --- a/util/yank.c
> +++ b/util/yank.c
> @@ -146,8 +146,6 @@ void yank_unregister_function(const YankInstance *instance,
>              return;
>          }
>      }
> -
> -    abort();

I think we can't silently do this.  This check is very strict and I guess
you removed it because you hit a crash.  What's the crash?  Can we just
pair the yank reg/unreg?

>  }
>  
>  void qmp_yank(YankInstanceList *instances,
> -- 
> 2.35.3
> 

-- 
Peter Xu


