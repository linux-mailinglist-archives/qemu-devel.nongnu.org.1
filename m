Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DF7CA0F7
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsIJg-0004M8-Me; Mon, 16 Oct 2023 03:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsIJc-0004Ly-I7
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsIJa-0000W9-Ki
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697442421;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VA9Nmg3WmuR3i78eTWmOaXJKkikCBLBa58/8vml63WE=;
 b=G9WRoJDUnWSKlMkjNWNcJI2nhB2OKsaVfCrluChu52b9/C/eWi/GPKYzz8SGi69h094Jow
 MNX1beNm+/JXt/ohx4IOcBUqdeFsBpkT7j3kBOh1O1fEK/nGaSV4Vt1l5wUi/evcAzAISL
 1+7hpndJKuE0KWzVSFWDJaKx4uBuZ0A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-MWCaV9z_PMaOz2FPKCD4VQ-1; Mon, 16 Oct 2023 03:46:49 -0400
X-MC-Unique: MWCaV9z_PMaOz2FPKCD4VQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4067f186039so30706225e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697442408; x=1698047208;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VA9Nmg3WmuR3i78eTWmOaXJKkikCBLBa58/8vml63WE=;
 b=xMuowjaM4udcVkXKujm9IlfaJsy+kgvsgLW1NQoUpTZKcPz57wnWozMR9/nkACha3E
 1dCehizj8TEyVC4JLNPCeJQCub7ZCWN0YAW8rVNlFsVBsk2ivVW+xKLmQdWg+Z71FIYm
 PIPINck9HZ0TrVLxh096/PzaI2QCbaxj15667+phYI43QqF4MFnSv2PoHZ75x4cgs1gf
 pBA+SHN15amqGtZo4Mssf24p5Cf2FRV0hGcAoY2mVvwWmHRbKxzC20E8UDEr6LtkMmiz
 4G6ytoTvW43X7wJathnyrjGJxtmRvDiEiriYTVuyJmoVw+qv4wiO9O5l9oncTgdCd8vR
 WFcQ==
X-Gm-Message-State: AOJu0Yy8DMfVPeyF7CunXOGcDDsawRnocbyYcykWBbpqpdvRwtekcxrH
 36Megvu7XSsEm38F/PY8rgjGtAEGVmJtqNe/7PsHtrlWdyXuLQYvfOuYHnLJ5Fue1scA7/9o0NA
 hyffiY0IruMLgG80=
X-Received: by 2002:adf:eacb:0:b0:32d:9395:dec2 with SMTP id
 o11-20020adfeacb000000b0032d9395dec2mr9114922wrn.71.1697442408341; 
 Mon, 16 Oct 2023 00:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHEHTdzpeQv6hzFIXZDRAsOnSWCYaXK/mB75Mj5L4brV/27d4DiDLOxWSaWj1P9Ji43bXKRA==
X-Received: by 2002:adf:eacb:0:b0:32d:9395:dec2 with SMTP id
 o11-20020adfeacb000000b0032d9395dec2mr9114911wrn.71.1697442408058; 
 Mon, 16 Oct 2023 00:46:48 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 w18-20020a5d5452000000b00323330edbc7sm792706wrv.20.2023.10.16.00.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:46:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND 7/7] tests/qtest: Re-enable multifd cancel test
In-Reply-To: <20231011184604.32364-8-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 11 Oct 2023 15:46:04 -0300")
References: <20231011184604.32364-1-farosas@suse.de>
 <20231011184604.32364-8-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 09:46:46 +0200
Message-ID: <87fs2b3t7d.fsf@secure.mitica>
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

Fabiano Rosas <farosas@suse.de> wrote:
> We've found the source of flakiness in this test, so re-enable it.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

One test still missing to cleanup the serial file.

Will send it later and then we can reenable it.

Later, Juan.


