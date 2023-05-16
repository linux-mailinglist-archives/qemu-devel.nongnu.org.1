Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCA17052CE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywwU-0000BO-EO; Tue, 16 May 2023 11:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pywwS-00009n-3G
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pywwQ-00038b-Ea
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684252221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gP+EAKtI1IgtRx/xIJkvnJPnXbPEkQRP15y46jgAgS8=;
 b=a1P7r+zyKk6h03bCKtQzuvRc/rc8c9ypzXGtwydr4xxOB9oyJkVuq212iXKmNcKI00soeh
 h324WDmWvr8tb8w7LH4eR3y9LQyiBiMBhvREq+1PeQq+Z90uI00G4+lu4rME7kosj0R60k
 fpng5tRZjxUFbWwujArlFG8khvtrnYA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-C0PNC7B3Mrqq-eN1b6cDhQ-1; Tue, 16 May 2023 11:50:19 -0400
X-MC-Unique: C0PNC7B3Mrqq-eN1b6cDhQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-61a3c7657aeso22586546d6.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 08:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684252219; x=1686844219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gP+EAKtI1IgtRx/xIJkvnJPnXbPEkQRP15y46jgAgS8=;
 b=G3x3JzjpvjlJ2xMFzGfa2B07ctmyK2nBz1NHHShorohK/tW2FBG+2fJPRHK4/gWBKi
 s0YoRgI9OBjvQrIR7Md90RNvPu3OouJHIhj5mENNFzuZz7/lBW1DMuHFTcgoadBmQdDk
 g7hOhQmHyp0KWDmFPbeKmYMx8sHQtbQxlwzYPGwZZQUm9XFJV9MlK4dbm2ZVsByzmjfG
 j+AZ9h60z7AuJJ7TmLNFDknifYixIpi6obK2lEJoYyfBFf6xBkVs9mmwmGuVdkgBR7gJ
 0HV68Wip+7tWeMhDG5NaOvtNQWfOEBigNCdhelN5wtY95OdFvqzUtLNr0wLgrcy+yYFx
 NY4w==
X-Gm-Message-State: AC+VfDxKEdTlUAtEimyMxIjxDd5DFuV6KrFDDxkYGDRmU+y78e3zZubz
 CKlLoVXJgoeH1MQQDagFLnWgjjZVq87zD3T0ekPZw3Up6kKtmFFGPpMcKft3wSvggOhhHaiLnCg
 e2XOyDLqyRZZusPjKD43xGcs=
X-Received: by 2002:a05:6214:508b:b0:5ed:c96e:ca4a with SMTP id
 kk11-20020a056214508b00b005edc96eca4amr20056198qvb.1.1684252218893; 
 Tue, 16 May 2023 08:50:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wnbDQWr7XU0qi61nDUSR4Qndut8e5ZS6ju9Q5NQ0BmLWTNQ9t/y2fcqBgfr9YEl17ICfz2g==
X-Received: by 2002:a05:6214:508b:b0:5ed:c96e:ca4a with SMTP id
 kk11-20020a056214508b00b005edc96eca4amr20056183qvb.1.1684252218621; 
 Tue, 16 May 2023 08:50:18 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 cx26-20020a05620a51da00b0074e3cf3b44dsm664409qkb.125.2023.05.16.08.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 08:50:18 -0700 (PDT)
Date: Tue, 16 May 2023 11:50:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] migration: Fix duplicated included in meson.build
Message-ID: <ZGOmOccOq8oV8Uar@x1n>
References: <20230509170217.83246-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230509170217.83246-1-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 09, 2023 at 07:02:17PM +0200, Juan Quintela wrote:
> This is the commint with the merge error (not in the submited patch).
> 
> commit 52623f23b0d114837a0d6278180b3e3ae8947117
> Author: Lukas Straub <lukasstraub2@web.de>
> Date:   Thu Apr 20 11:48:35 2023 +0200
> 
>     ram-compress.c: Make target independent
> 
>     Make ram-compress.c target independent.
> 
> Fixes: 52623f23b0d114837a0d6278180b3e3ae8947117
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


