Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B672E835
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 18:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q96iz-0001v0-Sl; Tue, 13 Jun 2023 12:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96it-0001up-Ot
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96is-0007O8-6p
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686673096;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnjcEM0/Hsx/b9xCAPkFElter2Wjb3YQq8/ruvkYDWs=;
 b=CI3ZPvav53UIL9ZZ0mgZuKh+sSuqKdPiV46oYa5bY3AJrLFN8vnBAPxv+fvCK47UEVs9vJ
 eaJre1Lz1v/RX6H8mFeT3kP/uMNshR4avNBrgD/I/6AIrJVNI9Si6+57QonkBc4z5Nvtlo
 NkIPoKyda/xQQoJCKYwtn11qfuQvrJM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-AdLE-iLpOEyfQkZEhNdhdQ-1; Tue, 13 Jun 2023 12:18:14 -0400
X-MC-Unique: AdLE-iLpOEyfQkZEhNdhdQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e835ce65so25402695e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 09:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686673088; x=1689265088;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nnjcEM0/Hsx/b9xCAPkFElter2Wjb3YQq8/ruvkYDWs=;
 b=Y4TfQ0kuAffTPtCC2pOVqmmF3jhhJubhEDFIowpH0761sGpn0QY6g8VzQCThwNzHKq
 23r/Pl3iXhyZDXkrMql1+EedJR0u/JFiNi1wSyijoo+2siS49AyS/xT8RCoEc9JX8Y8h
 /Ohx7DPRjN1sqfRN8j+riC1Xl/piZmpK85UHk6A2iYf+kVZMCV7XhnNAwlqoBPU2TnBS
 U35eLSn5E/RYcUrMuocIy3DQkCddCEhfcZXKWiQq0s1dQ6ioOhlnbG5SRGwqXS9U6OWh
 BZiBesK/aSKeuXqlWrzrnbqrotj3qT6nmLTaZY6vkNDBezN6WpmoRU5EMQHAsVdni78E
 L2Kw==
X-Gm-Message-State: AC+VfDz7oCRZt+Y0Pzovbiew7C6wdeWQ/Kbo4tOXIqwSy3QaXLpLA6UI
 DMIBXcqpWqSBfLlEMEp1hM2PP8lDaOilEJo4LMeKGlJr0xCdn7gu1ZArgA3Iry5Lxv6n7ZxEV/g
 2Chga368Fr68VNgo=
X-Received: by 2002:a7b:cc82:0:b0:3f6:f4b:38bd with SMTP id
 p2-20020a7bcc82000000b003f60f4b38bdmr8574314wma.8.1686673088087; 
 Tue, 13 Jun 2023 09:18:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Bn6x0co7MhH5kyoB+FITYmmh+hKqt8WR/xe+LupCTemHh4TuH1E1P1KujNfZ0qJwR9P/y4w==
X-Received: by 2002:a7b:cc82:0:b0:3f6:f4b:38bd with SMTP id
 p2-20020a7bcc82000000b003f60f4b38bdmr8574288wma.8.1686673087801; 
 Tue, 13 Jun 2023 09:18:07 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m13-20020a7bce0d000000b003f42a75ac2asm14895250wmc.23.2023.06.13.09.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 09:18:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 2/8] qapi/migration: Introduce
 x-vcpu-dirty-limit-period parameter
In-Reply-To: <168618975839.6361.17407633874747688653-2@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 21:32:59 +0800")
References: <168618975839.6361.17407633874747688653-2@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 18:18:06 +0200
Message-ID: <87mt13e3pd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Introduce "x-vcpu-dirty-limit-period" migration experimental
> parameter, which is in the range of 1 to 1000ms and used to

milliseconds

> make dirtyrate calculation period configurable.
>
> Currently with the "x-vcpu-dirty-limit-period" varies, the
> total time of live migration changes, test results show the
> optimal value of "x-vcpu-dirty-limit-period" ranges from
> 500ms to 1000 ms. "x-vcpu-dirty-limit-period" should be made
> stable once it proves best value can not be determined with
> developer's experiments.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> +#define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* microseco=
nd */
> +

microseconds

I guess that the problem is the comment.

I can fix it when pulling it.

Reviewed-by: Juan Quintela <quintela@redhat.com>


