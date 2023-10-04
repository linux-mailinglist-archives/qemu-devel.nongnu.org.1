Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 776347B8186
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:59:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2P5-0007ux-5D; Wed, 04 Oct 2023 09:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2P3-0007uo-UY
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2Ov-0005SK-UL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696427937;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9w265otSvXibAwL9fpKTh6h7/SW0e9wdNRreYMlHK+w=;
 b=GMd7uXW9ZqYfriZbNRksl7F6OYASEOqsE7M/vRZs5WZEv0JbE4jFQiMfysplsG7oseNUzg
 JSOfc9IXdFRopo7nSCDQZH/beYB9yZDs1dMyrGQcIC56VcTRkhPboKm9z+IafALZYAGNK8
 HgLrwRugjEOroZ9EjLNEhBLdPHteG3A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528--s8lUpbSOpOcCZwRhN9RJQ-1; Wed, 04 Oct 2023 09:58:38 -0400
X-MC-Unique: -s8lUpbSOpOcCZwRhN9RJQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4067f186039so13692235e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696427917; x=1697032717;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9w265otSvXibAwL9fpKTh6h7/SW0e9wdNRreYMlHK+w=;
 b=nTIMH2s/OT95TIZYQdxLE9MG/9TFVB7E5L9L/kDFxjRMrJS46Y/F0Ej9yFf4IPjv/Z
 S6DHAnV4D9Vk6gtDO7QvcGuI0jDf18NP09jiuhOeEDjo3d7C1w67IErQC4cgI/U8i1Yl
 771tferAw/iwa5rWtFUmVY+q46FeSxUP9PX89cj0AtwkzDkTk19uCFhPqpvaKQ/1bup2
 I9nmrWRpoD8LRIXO5x7aAYgxUyF2d+CCzxOvmoypQWEvTpSNPN1m+dcByNm72fQkQTgf
 cDcvFT8od65L9XtG56MFz9JkYLUPIPmsZWShHT6DdAWMMN4NgPDEPeUjqh+4LSxLT6Cc
 VQzg==
X-Gm-Message-State: AOJu0YwMUN+UoZWkAsCHtb2z3TXwJ0nx+XaFtfm+zdChwuDfCgR3gumP
 PaHesklaf2PB5Q7SeWuG/sFGqgbMzhZRkRT1ybuRq5zbxlweFXb4CP8J2KYoBaWfo3wNwxnhECM
 85eRUGXSBpQyFmMY=
X-Received: by 2002:a05:600c:21d1:b0:406:53ab:a9af with SMTP id
 x17-20020a05600c21d100b0040653aba9afmr2347695wmj.10.1696427917520; 
 Wed, 04 Oct 2023 06:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhBB0lx8TjxGPew233Iucezd1fUG5997H+b54Rv356XJMrCjcHmXCPbAQVD/YI3uuvcYYFDQ==
X-Received: by 2002:a05:600c:21d1:b0:406:53ab:a9af with SMTP id
 x17-20020a05600c21d100b0040653aba9afmr2347674wmj.10.1696427917137; 
 Wed, 04 Oct 2023 06:58:37 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c229100b00405959469afsm1636328wmf.3.2023.10.04.06.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 06:58:36 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3 1/4] migration/qmp: Fix crash on setting tls-authz
 with null
In-Reply-To: <20230905162335.235619-2-peterx@redhat.com> (Peter Xu's message
 of "Tue, 5 Sep 2023 12:23:32 -0400")
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-2-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 15:58:35 +0200
Message-ID: <878r8i32wk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Xu <peterx@redhat.com> wrote:
> QEMU will crash if anyone tries to set tls-authz (which is a type
> StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
> qstring just like the other two tls parameters.
>
> Cc: qemu-stable@nongnu.org # v4.0+
> Fixes: d2f1d29b95 ("migration: add support for a "tls-authz" migration pa=
rameter")
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


