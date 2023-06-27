Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07173FBA5
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:04:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7QL-0008DB-HC; Tue, 27 Jun 2023 08:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE7QJ-0008CT-Op
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE7QI-0007rv-AA
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687867433;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wiCYqtda/6YCcYnUC2sP9jMKLvHDPYKWY72i0MyCwcc=;
 b=cuRnS10cJUqye7EAsbjxEW68z2TEX3nurZ+14ZYA6ac4tB/7aJStqMXgED75bOkiIPe1Ze
 v6ANx0ANYG7RyPmKmXg/GilwZtKprwsyyEWlPG1lAemhwJd8MC+FFMbg7beR4Ok4LBWQk6
 r4yOIRok0VI762/DvHa+20rW/2Hkd0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-DskaassONOGloB84xHBnAg-1; Tue, 27 Jun 2023 08:03:51 -0400
X-MC-Unique: DskaassONOGloB84xHBnAg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f9b5cc7298so19430685e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867430; x=1690459430;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiCYqtda/6YCcYnUC2sP9jMKLvHDPYKWY72i0MyCwcc=;
 b=hsO6KZtcP6z/GfhmSMGgJOVNO3QU+urwNkDMMVYws7nFpLcfstmpWvDXvdvc5CNwZ9
 uZQBblFH0yWewvnrWtY6gKbqN1cWkTmGSyBd4IO8suB1B+UgywPo307glYj3ugeVXBJM
 LMX+nx1wMWlz5ECNeEIW5rb15qc1YN+Ot2BeRdMK/+uFScOnw9BfmywpGyVjQN8IMHry
 VQ3l8GwKPq/dJwDb19MAjF4Ygu/FhO5pLiAtR7V+NKdaGDrqlxTzszEPmDzpT5Tg7vT6
 mu5EfXTcOvROCzyhYmuonOGYssF5MRkW99XV1uvLofrMH2wSwAD6yN6eR7Zkj6OoMhnq
 VEEg==
X-Gm-Message-State: AC+VfDyw5EBfJAoPb4r9VBtcu9zVtjmvRY2hY6bp8z5ISVAhqT8vd2US
 /xUC3u78TyjzC9FKEpLDI0AAxz49wUGEc9O43ESJKvmdPjiV1KgtGmGpZgNAv2nIibGzKIoJi8X
 ORTHOvyXT49TLHeE=
X-Received: by 2002:a05:600c:21d1:b0:3fa:a6ce:54ad with SMTP id
 x17-20020a05600c21d100b003faa6ce54admr3105035wmj.6.1687867430416; 
 Tue, 27 Jun 2023 05:03:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eRQ13eF2x5JIGqbu3K5jCxF1PmvC2bg///dzbg68GrEk2XdynvMTYQalFgWlOGsD4C2LCjQ==
X-Received: by 2002:a05:600c:21d1:b0:3fa:a6ce:54ad with SMTP id
 x17-20020a05600c21d100b003faa6ce54admr3105016wmj.6.1687867430108; 
 Tue, 27 Jun 2023 05:03:50 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m6-20020a7bce06000000b003f733c1129fsm1819713wmc.33.2023.06.27.05.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 05:03:49 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Claudio
 Imbrenda <imbrenda@linux.ibm.com>,  cohuck@redhat.com
Subject: Re: [PATCH] pc-bios/s390-ccw: Get rid of the the __u* types
In-Reply-To: <20230627114101.122231-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 27 Jun 2023 13:41:01 +0200")
References: <20230627114101.122231-1-thuth@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 27 Jun 2023 14:03:48 +0200
Message-ID: <87ttutaz8b.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Thomas Huth <thuth@redhat.com> wrote:
> Using types starting with double underscores should be avoided since these
> names are marked as reserved by the C standard. The corresponding Linux
> kernel header file has also been changed accordingly a long time ago:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/s390/cio/cio.h?id=cd6b4f27b9bb2a
>
> So we should get rid of the __u* in the s390-ccw bios now finally, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


