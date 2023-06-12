Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CAE72C59B
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:16:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hO1-00013F-Ip; Mon, 12 Jun 2023 09:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8hNy-000134-28
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8hNw-0001Eg-54
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686575701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvrfFfBDNYZvdTHQXh1vwojfuV3w4yH/dfHNDSzmQh4=;
 b=LDjkBkwJqjTmJQsQGDJv4WxPdugD8oVgJQ34KdbvoIVAgF04ugylh/IesBX+x+bUfnVA7O
 EUcqX22ryWvesAoGnO+1/WQFbUbgDogYKp2fgbIS1XEkTMmx4GnMvNiErRROVaqxQQO7D9
 Qq3GMbFxua+tRgAVXW6XJwzx1NG5sb8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-E5ztIaA0Okenjq_WQXw2Gg-1; Mon, 12 Jun 2023 09:15:00 -0400
X-MC-Unique: E5ztIaA0Okenjq_WQXw2Gg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-39cb18a4872so142994b6e.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686575699; x=1689167699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvrfFfBDNYZvdTHQXh1vwojfuV3w4yH/dfHNDSzmQh4=;
 b=SEkR9CWGB8mnnPA9aiVskK0zW6I88DXjhb9+CCYO8u11Gr+BoYAHse1TEjOWQ0DPj6
 M8mxvTrDtEqL2sjKBVrpvEaKEb+q4eQvup0NyUpJ2JKt3tHX5x1QxPpanOCBZjD+C6Wf
 SPddHXzVDVn0GGyR+IQXHcvEqBUDa6DSFF/Zj9leb84FcbJ3ZW0ACq1DHpIMeW1e6xmv
 J6P1WHxIXYzZuAxsNHYJdDJ0Q2Iu4OhFQdVQ9wwHxAhCDtwmMqbxv6MwCrvpFRF64qYK
 TJoj0SlLPpSdrU1PKjaT8xUwtXMII3gxBKsaYpmMsaDq4WU45NaHLqTvpfCNlRm3LRGO
 mLjQ==
X-Gm-Message-State: AC+VfDxkBJhdw8qY7/e+SPAdsZnNSZMiKuX+iaRf0O/1BQZb61TH2tM+
 coZADuLvWd8mXZYgcNgYaf/hyB3QEHqWCBTXWq4bNpSJMZ61uNoFsTP7f9OswgeghH+2IdBGjiq
 2n4KbWIpkF31rlzo=
X-Received: by 2002:aca:3dd4:0:b0:39c:8140:9f25 with SMTP id
 k203-20020aca3dd4000000b0039c81409f25mr5376927oia.0.1686575699406; 
 Mon, 12 Jun 2023 06:14:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AdEQ5Ak9wvPRcAJkgrvr8RghIdFPCxm7a4v2LoSXsySGeqMh2Y46jz/bVk5A2py5RCAUfdA==
X-Received: by 2002:aca:3dd4:0:b0:39c:8140:9f25 with SMTP id
 k203-20020aca3dd4000000b0039c81409f25mr5376913oia.0.1686575699101; 
 Mon, 12 Jun 2023 06:14:59 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c25-20020a0ca9d9000000b00626234be222sm993491qvb.57.2023.06.12.06.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:14:58 -0700 (PDT)
Date: Mon, 12 Jun 2023 09:14:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com
Subject: Re: [RFC 0/2] migration: Update error description outside migration.c
Message-ID: <ZIcaUMIGZEYbToiK@x1n>
References: <20230526115003.212004-1-tejus.gk@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230526115003.212004-1-tejus.gk@nutanix.com>
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

On Fri, May 26, 2023 at 11:50:01AM +0000, Tejus GK wrote:
> Hi everyone,
> 
> This patchset aims to cover code paths in the source code where a 
> migration is marked as failed via MIGRATION_STATUS_FAILED, however the 
> failure exists outside of migration.c, and without a call for 
> migrate_set_error at this place. 
> 
> This patchset has been split out from the patchset sent before which 
> covered cases of such gaps in migration.c aswell.
> 
> Previous patchset: 
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04463.html 

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


