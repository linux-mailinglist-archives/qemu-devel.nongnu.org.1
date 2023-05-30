Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D4716B3C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:38:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43Gy-0007Ax-0J; Tue, 30 May 2023 13:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q43Gw-0007Ap-VA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q43Gv-0005qM-Mn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685468197;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Xy5vAbhJrft/dP28QxlH4WxYA05FQPiHb1+gQJ/veA8=;
 b=XwyoaBg1q/VDQRBOTb71zCRlrUDcrkp9oxCb1KXoMTXR/dnO4OMigTUbe6rn/r67FUnEls
 Ssid/Jg6/ONwXMkDMhfPrR8pcb1Yt75FFJWhFjfxqfdwTEaIUuG9ImxL1idHv5qbFkJatO
 utjJHcwy+I5CAWTOqbxI3PMQm+4uZGA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-bVgXUtpNNWSnCKqYZBci8w-1; Tue, 30 May 2023 13:36:28 -0400
X-MC-Unique: bVgXUtpNNWSnCKqYZBci8w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ae4ed92eeso1369869f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685468186; x=1688060186;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xy5vAbhJrft/dP28QxlH4WxYA05FQPiHb1+gQJ/veA8=;
 b=CPMt3YWW95vr91S5mfX0F7FA1qKJVtcJHxqYF2pzgmmoDgj53eQAuuRnfWDoMKL5r/
 tSr9XKMy72n0g8R0G5Gnw+7UZvGyRnjwDcU10PmJwS017Atrvml1xrw4e8dlQkjpxB3l
 xdPcYIYkvqRzJOLdgjSosfergT/0WHyauA5VOyJeHUU230oAy78BBGi66ae9Nv/O4fTj
 H0FQ30OtDEeAms/j6r7XVV73fMyTlXdw6CccGnUx1dSHv/Gx97fIcTQnunjuexRLKKx2
 Hwy1XCbpe6C5aATyE+hJqBKCZ9i1TJAp77lJstxfcRARLz1UqXJwfGHuySb+1INHPZXc
 hP4g==
X-Gm-Message-State: AC+VfDwK4DtVzvuOO8gmGh38NwgYeecILcocWM25mYpqC16nEab0/e+1
 aGGlJ5Y008OkPEV+67XUrnTSJ10MuC86GNp/iC9XqNLeQ1hq6ngoBxu4eWq2UEP1xjehwkLbqd2
 XijlnOvsOD4jYiYoj6q2YueZGGpVCTUULJnQ8BRed8ozjpv/4gC2nBhSanMesg5OxUX3jyNEiv+
 LfTg==
X-Received: by 2002:a05:6000:1374:b0:309:5029:b071 with SMTP id
 q20-20020a056000137400b003095029b071mr2417864wrz.45.1685468186804; 
 Tue, 30 May 2023 10:36:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VfOY1cTDWmFhJS0XFiLJs+bip5EX6OwiClhx1FRhpwTpQt/goB98kfI0DEzLM2C4haJdmbQ==
X-Received: by 2002:a05:6000:1374:b0:309:5029:b071 with SMTP id
 q20-20020a056000137400b003095029b071mr2417842wrz.45.1685468186453; 
 Tue, 30 May 2023 10:36:26 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 w8-20020a1cf608000000b003f18b942338sm18125404wmc.3.2023.05.30.10.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 10:36:26 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Peter Xu <peterx@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 04/16] qemu-file: Don't call qemu_fflush() for read only
 files
In-Reply-To: <20230530122813.2674-5-quintela@redhat.com> (Juan Quintela's
 message of "Tue, 30 May 2023 14:28:01 +0200")
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-5-quintela@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 30 May 2023 19:36:25 +0200
Message-ID: <87y1l5vi06.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Juan Quintela <quintela@redhat.com> wrote:
> This was the only caller for read only files.  So change the test for
> an assert in qemu_fflush().
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Drop this patch.

As Richard has strong opinions about calling fflush() on input streams.
I still think that it makes zero sense to call it on a migration input
stream.

But I don't care enough to fight this battle O:-)

Later, Juan.


