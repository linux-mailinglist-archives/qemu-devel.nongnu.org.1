Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4513779F28F
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgW75-00062f-TP; Wed, 13 Sep 2023 16:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgW6z-00062A-Ox
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgW6s-0006KE-59
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694635513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1AF/JAavGJjJOzdTmuh5PIwSO/Vf8+r+596p2Hq8nc=;
 b=ZCcb0jHeAftlENHtmn1fujbeTZtqHRLaL2JHS2xGaQ+0+lG42sSlKpv1+zErNyADJwU7nh
 dImV9eBvCPPb+LNF1caCHxANx9D/KqIhandNWN9M9k0OOCkJhRe0GyTi/nBBsij+UqBCOR
 2q7R+z0hOglj4R01bI11kHzOibc6cVA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-UrLNbOtTOxmwk6ZvfvF5QA-1; Wed, 13 Sep 2023 16:05:11 -0400
X-MC-Unique: UrLNbOtTOxmwk6ZvfvF5QA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-655cbf1c0d2so530356d6.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 13:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694635511; x=1695240311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1AF/JAavGJjJOzdTmuh5PIwSO/Vf8+r+596p2Hq8nc=;
 b=AwECnr8N4IJHSA9/AhQVs5ttIemRzSZa4p11PjU1OH4NKRnBVYg6vcV1f5uE3kJW82
 My/t0UEjlwyM6/k9IoKp1sKIGM+blfgbAb++DX08bhmGH8ucxukjtW3Tgk0ObmFBdfGi
 IScwRezZ7jgv5h9rQz0Ghi3l1840X3AHQuHp9f4PBPBgzm/BO9mlZ90oRDPeW0d4a1T/
 okqXtZczBZo5LcOAq/3rm8yiDhUrkwzXAewyOx8ljDQe6GjXOSwYw6vT1elvkhbhX+2F
 hTJTeYdhIvoE4mOY0tM2QgBLTv4m8zuFdiTTDkejbmQ5LcxX9B7/8RMU6itTnrbTNgVa
 /YhQ==
X-Gm-Message-State: AOJu0YykxsnIENOBEx2pCiPxzvs3nD8C6XtWLfx5SpA2qOSQpByPUiya
 /OV2gDjpMl1MJpFO+4DYcqkWsfcjMioVOmhENDC+ZbR2h75VRLeu5PjfNFhLHlVA7ho7L9JGCC9
 cR1vwL1abreyObC0=
X-Received: by 2002:a05:6214:21ac:b0:63d:2d7e:39f1 with SMTP id
 t12-20020a05621421ac00b0063d2d7e39f1mr3595061qvc.2.1694635510985; 
 Wed, 13 Sep 2023 13:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Z+aFh57sydx5mh8Wbx9qb4P0ExXl2Q9J/s4e5DIag4dSVTMQMi0RJOOLVzwJmYzoFs0ifQ==
X-Received: by 2002:a05:6214:21ac:b0:63d:2d7e:39f1 with SMTP id
 t12-20020a05621421ac00b0063d2d7e39f1mr3595039qvc.2.1694635510722; 
 Wed, 13 Sep 2023 13:05:10 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 p10-20020ad451ca000000b00655e4f57732sm2969918qvq.35.2023.09.13.13.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 13:05:10 -0700 (PDT)
Date: Wed, 13 Sep 2023 16:05:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v6 08/10] migration/yank: Use channel features
Message-ID: <ZQIV9RZFS0soEOJ4@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911171320.24372-9-farosas@suse.de>
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

On Mon, Sep 11, 2023 at 02:13:18PM -0300, Fabiano Rosas wrote:
> Stop using outside knowledge about the io channels when registering
> yank functions. Query for features instead.
> 
> The yank method for all channels used with migration code currently is
> to call the qio_channel_shutdown() function, so query for
> QIO_CHANNEL_FEATURE_SHUTDOWN. We could add a separate feature in the
> future for indicating whether a channel supports yanking, but that
> seems overkill at the moment.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


