Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54387B85B2
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:50:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo54q-0007Sm-Bm; Wed, 04 Oct 2023 12:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo54o-0007SV-3x
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo54j-0007YL-CP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438214;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ibv2gfyffD7mBCLswg58YH1LT5fl7p+acWFbR4V1ADk=;
 b=BMv3NNj0ocr4JU8e4DGBwwRCwWWjbh/kLG0myRXL1OLLDazIgNtYp4dDLekI+vwCRw2Ohx
 S+DOvIkWq9/bsjl7zS2OMLy8++cwD4P6j6d0FwC0cfMvZa5Yn2olq3/+HF8U360lZtJKTC
 b0lJUHlnS8QZ6bgWpdL+nyW6TU38xdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-d4nXAC1XNimuk_BwP4ojYg-1; Wed, 04 Oct 2023 12:50:08 -0400
X-MC-Unique: d4nXAC1XNimuk_BwP4ojYg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so43196f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438207; x=1697043007;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibv2gfyffD7mBCLswg58YH1LT5fl7p+acWFbR4V1ADk=;
 b=eOLy8vahsrAZ8jfbufaC24UD7JcoOhtAW+dEdgmY13p3VuN0UC5hi0QRWzK45cLkg0
 XqYyKcEkTaeXDEstVjBiiPF/lyO19FskqTojff6m33lkcBwOKIIfEVELeHV+3/TbGqq9
 4wErVpsJfAbC67oOcj6y/3HHaMFKM0ItjQPW+bDGodD/DGg/AHaFc7eomLrWGF9UbXbb
 34vFp/rE/YI/MzDMdHjv+Y1/R0/dCwev5JFQNnUHBnIezbLDvHA3BEOuLyDE8URm8aLJ
 PDa8st3N4SfuMKrTLXL7myy25TYFsziJuWZ5EmIAD870Zv36fwLOmdpx497zYdOGvEsq
 +UIQ==
X-Gm-Message-State: AOJu0Yx4p9DbAUa8G+e0woouEXh4XXRIh36DYbXd0Z9xpKiiHOcw32bf
 7Mj3e0//E61CFynN1wtWCJeNVNF34M1bRVmwJb7BctmAzuraG1orl/Ndxf0W3jNTDiey8VcTw3M
 ON6Xb6g4XhW+dm4I=
X-Received: by 2002:a5d:5550:0:b0:323:11e8:5df1 with SMTP id
 g16-20020a5d5550000000b0032311e85df1mr2688759wrw.41.1696438207226; 
 Wed, 04 Oct 2023 09:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV45E6ttppmZqyWvrU47JaKapc7F4YKNWKMX0NuwZ8DrwXgymLt2+Wm0Tv4zJKUCmDwl+TIA==
X-Received: by 2002:a5d:5550:0:b0:323:11e8:5df1 with SMTP id
 g16-20020a5d5550000000b0032311e85df1mr2688740wrw.41.1696438206889; 
 Wed, 04 Oct 2023 09:50:06 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b00406447b798bsm1945838wmj.37.2023.10.04.09.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:50:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 31/53] migration/rdma: Delete inappropriate
 error_report() in macro ERROR()
In-Reply-To: <20230928132019.2544702-32-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:57 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-32-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:50:04 +0200
Message-ID: <878r8iuybn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
>
> Macro ERROR() violates this principle.  Delete the error_report()
> there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


