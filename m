Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493F7B85EF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5Ax-0004JO-Qa; Wed, 04 Oct 2023 12:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5Av-00047c-TO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5Au-0002wm-81
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438599;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=U/FRODiQ88noY21ECLpw5Hrha2fLlSln2COR3L6N62o=;
 b=ExEn5Tijn6ux464cP11sRq0a5by0Q/NJXx6gR1g5uhSm1fxF+ubqW7pyYVdDOymITWo5qY
 q8hi+3AltSaH6khsNEoKhIWWLJLcpMYAisvIy98+YWgx+q7MMYlRjqLNl9louot+PA+a9w
 USfDIdDMHrUhNY9w1fb+hrL9X7Ox0rE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-Hmf7EOiePEiS8S-FhSXXUQ-1; Wed, 04 Oct 2023 12:56:36 -0400
X-MC-Unique: Hmf7EOiePEiS8S-FhSXXUQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so18281815e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438595; x=1697043395;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/FRODiQ88noY21ECLpw5Hrha2fLlSln2COR3L6N62o=;
 b=t/u/aHsJYBX5LRiG15LmpzptDjKUq1/Al4cQVY3FygSwBdd8PQT3kiof4nZX/2LmcV
 QRj8mT7CAEw4CC9bm8y/CPxmHAp+Vh/lMKWEnymcEJa8ZlKFNxttyMrhyeaVaCw5+X3/
 0DFfWOcdl+1Qrs5ffh5UISJzLKp4kHUERM9cW/tHXkpXAptFZtUMI6MEqqmAY77LNaKP
 Rsg+ThoMUA81Kz83Le38aolz4jm7I2WhpftV4C1GpLVoDoZjpGq1z4wz2F0tck8HJ+lB
 tWYVDxNN8GWiuNP3CcKDhZ19tJE409/kanaDv1PsVUqwKwzAbe8nfe5pa1skw8bFVEjn
 awug==
X-Gm-Message-State: AOJu0YweEyEO4I8wMcN/ZAxuFhGCFv1F+soiZUeDUFITxOuf6W2VpEbL
 7rpk5ftF+zT1cBIj29m/7s7Uv6TfkXk7Ni52jfKN+aGIVU+KcZ3wSK6jzmg2RM5iX701RsNx56k
 Dxwe60D0Juij6XzM=
X-Received: by 2002:a05:600c:2a4e:b0:405:49aa:d578 with SMTP id
 x14-20020a05600c2a4e00b0040549aad578mr2965548wme.37.1696438594999; 
 Wed, 04 Oct 2023 09:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbzL8asZiwvlBZZMydnEM/eciQaXN+BI9bD7oGxPyQHkVJsUaiCqpXl4Bnoxg+dgNm6BqP2g==
X-Received: by 2002:a05:600c:2a4e:b0:405:49aa:d578 with SMTP id
 x14-20020a05600c2a4e00b0040549aad578mr2965536wme.37.1696438594659; 
 Wed, 04 Oct 2023 09:56:34 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c280700b004047ac770d1sm1972322wmb.8.2023.10.04.09.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:56:34 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 39/53] migration/rdma: Convert
 qemu_rdma_write_flush() to Error
In-Reply-To: <20230928132019.2544702-40-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:05 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-40-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:56:33 +0200
Message-ID: <87a5sytjge.fsf@secure.mitica>
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
> qio_channel_rdma_writev() violates this principle: it calls
> error_report() via qemu_rdma_write_flush().  I elected not to
> investigate how callers handle the error, i.e. precise impact is not
> known.
>
> Clean this up by converting qemu_rdma_write_flush() to Error.
>
> Necessitates setting an error when qemu_rdma_write_one() failed.
> Since this error will go away later in this series, simply use "FIXME
> temporary error message" there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


