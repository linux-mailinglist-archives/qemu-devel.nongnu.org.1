Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533078F3E2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:21:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbo9E-0001tf-RX; Thu, 31 Aug 2023 16:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbo99-0001tJ-UP
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbo97-0000Oc-TV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693513204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ufk8GCiw/LwQVAZTYLTycpsT48xt2rPVrWRGaQbD81E=;
 b=DNtiUd7Zga+cN+KEtU49Wk6YnHFdaSZJKFRV1yUoF+NdbYMjzVfjrqX4yjAiGr7vXqQmMm
 dQFfFvqGsp9SBwFBebv8sR1FhTHEztUY0ayTKHsX7SEuqjF1Hffxtw2M9/sA2BLXGSDkTs
 CWtBxgSmi3G/mlXQQN7bFbp5FcqsnpE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-cqwv-qlyP9C0ncTjVtRsVA-1; Thu, 31 Aug 2023 16:20:02 -0400
X-MC-Unique: cqwv-qlyP9C0ncTjVtRsVA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-40559875dd1so2520231cf.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513201; x=1694118001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufk8GCiw/LwQVAZTYLTycpsT48xt2rPVrWRGaQbD81E=;
 b=hp9/dfXyoHHdOFs8BbjTD8NpihGdq7Pr1tJulaB7c1b2Vze6FAnE6TTzg/58fizMPv
 q4DlaVWA5TiLK4/BRj6leKy7MSNCybczu8bnIl03zBAitNtNw8g0p0imR9gJ/Inp7yrT
 rP3YTT9ZSgl6VU5NjPxfB9yUTUS57droEsRZ0GOwFMUO8Qeye1F9LtGiwlhqs67v7+qj
 4BGSXHVzsDFjgQrro2nsRFdDUxb5v9sNM6OZj4i7TtvLMB1XKixo+uxRXJUo4OLZHbZv
 E2nadsk+AtKwS4kuGbE7YGo4S0ceaT5C3LyLp8+i+dcWuFY4czQka3CSJFI8wz2LGjvr
 CWvw==
X-Gm-Message-State: AOJu0YxlCYJcewZJAy2wRaRZXqawb4dDG8ain2wm7EKU7JiyyUDVWhN8
 t6MhqjODDFM1HjooK8mOl6UXZ0R34ZqPqiGECgZfMgoqKRSkSUxDTxZVsurT3XYt3OKzTeMY05y
 fwFK+1jDx/JejvQ0=
X-Received: by 2002:a05:622a:1a95:b0:412:944:542f with SMTP id
 s21-20020a05622a1a9500b004120944542fmr554600qtc.2.1693513201284; 
 Thu, 31 Aug 2023 13:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFAF781BYCy/7xjebcfDDFV6O9tFD+MwHw2lCzWGRBIbm6hK0VSsMkVUfbwGvnURh5QKA8xg==
X-Received: by 2002:a05:622a:1a95:b0:412:944:542f with SMTP id
 s21-20020a05622a1a9500b004120944542fmr554577qtc.2.1693513200985; 
 Thu, 31 Aug 2023 13:20:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y21-20020ac85255000000b004109928c607sm882603qtn.43.2023.08.31.13.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 13:20:00 -0700 (PDT)
Date: Thu, 31 Aug 2023 16:19:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 idryomov@gmail.com, pl@kamp.de, sw@weilnetz.de,
 sstabellini@kernel.org, anthony.perard@citrix.com, paul@xen.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 stefanha@redhat.com, fam@euphon.net, quintela@redhat.com,
 leobras@redhat.com, kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 2/7] migration: Clean up local variable shadowing
Message-ID: <ZPD17rBVIoFgpBWA@x1n>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831132546.3525721-3-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Aug 31, 2023 at 03:25:41PM +0200, Markus Armbruster wrote:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Tracked down with -Wshadow=local.
> Clean up: delete inner declarations when they are actually redundant,
> else rename variables.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


