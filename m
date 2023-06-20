Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77659736F04
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:46:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBccA-0006U7-No; Tue, 20 Jun 2023 10:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcc6-0006Tm-KJ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcc5-00007Y-3S
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687272344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52HytyrF3US6GLrVAVu5nR1wponakPh543oe7UUcp1E=;
 b=SkOg5Bz04bYneqEjnQUVpVWNzl6yi0NXgn8mZftSXi6Ry6EaGm+fjsXdH5Qclgqv9id6fd
 dwMbl9KckaEw2Afep1kB7fCYlHZNL94V8naL7eqlv9GYspS4RjEd31g8AL2stGREyCWEvt
 3WxO1/IadEKsHLsuRODEJBbSS9fcyvs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-lt7sB9FyOLyss4oBo1WYWw-1; Tue, 20 Jun 2023 10:45:25 -0400
X-MC-Unique: lt7sB9FyOLyss4oBo1WYWw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-631e9a9e92bso3232666d6.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687272323; x=1689864323;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=52HytyrF3US6GLrVAVu5nR1wponakPh543oe7UUcp1E=;
 b=JIvhCpm//XJOSEKp7fC/QCF0nG5Ks/VTcGUR2efA6xxlMaHI6MImciWEXdtiwFstjj
 bdysGc9S9zY+qLrml6ZX0DyFMwSxRm27CbNrbXo6TdARm2onjdXHxJIqEQu1S1jbmFR4
 rNO4dMeosb5NgKYV9XhoMUC7ooe29ggUW/hU4ZzEkw+JiT7Bp9QQA1JxeRBi3rMMBBPC
 W+ESS+oH/gcD4KtwIQ3EFfQwPdh2Eow1R2Aw49nub9IbtKiPDxE2nG5FPZsDSk7Dhd/e
 PKHF6eH6R3syKQ2GyZL8fkpG2vkGFdfXXiiJC/3k2Ggg/WVwhzEFQMVouTjTfcsvaDlg
 0hOg==
X-Gm-Message-State: AC+VfDzlRlg24ShSU/yqvG+TqSQp6r1uXzq5hCcfKUZlJn5Eyul13U9b
 GEH/UJjeXoAvDWKR6UmJXRb088OUM2sSQyhFezxwvbbkiE55K4auX9Ghr6rlY79pbxB8kFx+F8t
 80d0KeaS6D6DcZ9E=
X-Received: by 2002:a05:6214:c6c:b0:62f:f6ac:abf5 with SMTP id
 t12-20020a0562140c6c00b0062ff6acabf5mr15420554qvj.5.1687272323406; 
 Tue, 20 Jun 2023 07:45:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XW/fBawrwoswiapmNJj2DjpAle3yhA5n6bEdRsqA+DTuDnXUqDHUxt7dakwft4wXBEmm0gQ==
X-Received: by 2002:a05:6214:c6c:b0:62f:f6ac:abf5 with SMTP id
 t12-20020a0562140c6c00b0062ff6acabf5mr15420536qvj.5.1687272323114; 
 Tue, 20 Jun 2023 07:45:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf493000000b0062623d8ab7esm1286799qvm.111.2023.06.20.07.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 07:45:22 -0700 (PDT)
Date: Tue, 20 Jun 2023 10:45:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJG7gVTambX/f3p6@x1n>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica> <ZJGXT4z95dMx0rd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJGXT4z95dMx0rd7@redhat.com>
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

On Tue, Jun 20, 2023 at 01:10:55PM +0100, Daniel P. Berrangé wrote:
> In some cases it is worth having a convenience option for user friendliness.
> 
> In this case, however, users are already needing to use QMP/HMP on the
> source side to set migration parameters. I think it is reasonable to say
> that doing *exactly* the same with QMP/HMP on the destination side is
> actually more friendly than requiring use of -global on the dest side
> which is different syntax.

The -global parameters also work for the src side for my scripts, so I only
need to attach "-incoming tcp:XXX" for dst cmdline here.

> 
> We don't document the way to use -global with migration parameters so
> when people see '-incoming' I think we are steering them into a trap,
> making it look like -incoming is sufficient on its own. Hence that user's
> mistake recently about not setting migration parameters.
> 
> Overall I agree with deprecating  '-incoming' != 'defer', as I think it
> will better guide users to following the correct steps, as is not a
> usability burden as they're already using QMP/HMP on the source side.

I'd say -global is definitely not for users but for developers.  Just like
we keep around HMP - I'm not sure whether it's used in productions, I
thought it was only for developers and we don't deprecate it eagerly.

No strong opinions here if everyone wants to get rid of that, but before
that I hope we can have some kind of cmdline tool that can easily tunnel
qmp commands so whoever developers using pure cmdlines can switch to the
new way easily.

Thanks,

-- 
Peter Xu


