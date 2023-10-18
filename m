Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31907CD8C9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3N3-0002QN-UG; Wed, 18 Oct 2023 06:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3N2-0002QF-GP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3N1-0006km-4B
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623301;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OulnyTfg9tZoV1Btrj8FlHHoiYIj16Um3j+TKHSiX8E=;
 b=H0fxVai5UtZqmiQ6gGgT+bBDuRvwlM2TLHRNUN701WxuF1ZGu7PwV4euvp62XVaAWpE7ug
 WtIcLAhfWNJw1Pa+cwZu3joNcaV0niV44B9qySnWLExowoWV7A+pCsBdUxUY9ZxWsEHyiX
 I4A4UkOdbN2u166h9djwUOgqrLFy+Po=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-oQ3r-_w8NeG5T3_OpE1SPA-1; Wed, 18 Oct 2023 06:01:30 -0400
X-MC-Unique: oQ3r-_w8NeG5T3_OpE1SPA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-405629826ccso47219085e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 03:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697623288; x=1698228088;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OulnyTfg9tZoV1Btrj8FlHHoiYIj16Um3j+TKHSiX8E=;
 b=UZSPNrKNNHWrlhaftYKuHlP4FIskuA5VFlPO3WxhOVMrx08wIZ12+kuzn1pddcnmc7
 wBEQWTsdyKnmZLXR5UwqK5vrwJd/ngE5OXfgmho+SLKJSALzOU26RVOjzWbXcCTm6tsF
 Mrhg7L7THkxCnWq4amVZ5TAFcO9J0WaMeZW1BzqgzWakEM0kC0Zs2fNYSCiF3//mTQRX
 aDhdgaXbLNhJkZ/ifHwjkjmOT65yMYONFn1XGKMm5NVA7BH3+fBahtJ1dcrxi5V4/53P
 qgVkQY5evvhJlKDaU86xHQf5mIACIXpUvh5uqoxWDKf8WorbBXbLQVN54arvX/KU4R90
 t5eQ==
X-Gm-Message-State: AOJu0YyNE1lM7HGF8AabEIshaWaYuMmBlnIeZds2mfZ4bBL0rgGud1qB
 wHnNn/Hi6XPrg1eDvVAUNiDefrx8A1je1rDuNtqhhI8fXdGHiNFOWN/7hBkSguaXZaKtoc02PMC
 5wMYwAlYvv8YJ1Bo=
X-Received: by 2002:a05:600c:4f0d:b0:405:37bb:d940 with SMTP id
 l13-20020a05600c4f0d00b0040537bbd940mr3771381wmq.0.1697623288644; 
 Wed, 18 Oct 2023 03:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJCOD+mQ6t1s0xN6WBda3DWLSiKOAQTdcVZVRJg6dX2DPG3ctEu3d8Rkz0GAE1cirRA4P+5Q==
X-Received: by 2002:a05:600c:4f0d:b0:405:37bb:d940 with SMTP id
 l13-20020a05600c4f0d00b0040537bbd940mr3771340wmq.0.1697623288003; 
 Wed, 18 Oct 2023 03:01:28 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 x19-20020a05600c421300b003fc16ee2864sm1213825wmh.48.2023.10.18.03.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 03:01:26 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration-test: Disable the
 analyze-migration.py test on s390x
In-Reply-To: <20231018091239.164452-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 18 Oct 2023 11:12:39 +0200")
References: <20231018091239.164452-1-thuth@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 12:01:26 +0200
Message-ID: <87mswgxn9l.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> The analyze-migration.py script fails on s390x hosts:
>
>  Traceback (most recent call last):
>    File "scripts/analyze-migration.py", line 662, in <module>
>      dump.read(dump_memory = args.memory)
>    File "scripts/analyze-migration.py", line 596, in read
>      classdesc = self.section_classes[section_key]
>  KeyError: ('s390-storage_attributes', 0)
>
> It obviously never has been adapted to s390x yet, so until this
> has been done, disable this test on s390x.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>


