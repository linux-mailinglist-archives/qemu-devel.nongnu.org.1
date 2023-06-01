Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B74671F637
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4r3J-0003WG-Tz; Thu, 01 Jun 2023 18:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r3G-0003Vh-Jg
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r3E-0005AB-V3
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685659547;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCfpC8lF0IvdcmCgzxImR93mbQZSLv79AwmVI1NTWi8=;
 b=TN9WGqJQpIRs1kK3uoZprpSy+u82xkqVwkDrKhp6izYc/SpOh1R6vIxmTx0A3EVY5dYyi+
 1OBJhUh1jSengsUHglWXCH5xw+BFJmGvWpYWPj22S8qPhOusVm4yRoaKgGzaOWxGq/j7V7
 xdwsWV6JCi+2w2Uv62h0B6AS1HKBCEQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-gqStSi2UPaOQ939tmFhhvA-1; Thu, 01 Jun 2023 18:45:46 -0400
X-MC-Unique: gqStSi2UPaOQ939tmFhhvA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f6ffc45209so7076805e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 15:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685659545; x=1688251545;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NCfpC8lF0IvdcmCgzxImR93mbQZSLv79AwmVI1NTWi8=;
 b=Lvza4YAsg1FbXDJ2MgU95CSPdGjPYf04A6WqK4OlimlhyZSdDMKShHbqK15HmfDoQa
 aKqsBTW2Ia2GHMleUayKr8+2LSFA5+gqIxv4u8VMSZuYpC1dFGaX9k4DlNRURCXlGDJB
 p9DhRDK4sA5jrK6rGCO2lLRDM5YnZZDhGqUuRjUcXFZA2NShKyFtP3oNa8foZvicyk5C
 hHYpp50+3aAp2AF4Y8RQfQAGRe5xKVF5EZotM6sq9tq6N1ghQqZnboZUumS4n/b+u0qf
 4X6LBEIouKoWboj+DAUnK/q+3q+44rNcLZByI6r5TqIns1PNbbbMXpDp68kEvwH9HW3n
 FhsA==
X-Gm-Message-State: AC+VfDwAlQLFBCUdEVqc/+IGBLqHrfVwHKJEiWRsNAWR9Zl3gX3vtFgZ
 z5ZWDiHHelmGV3+bQ4Ge/lSupMTKIHJSRNCn6JH0OceXimaAJMnN7BVlHSoz1kY9B4fe3UfO5fO
 1CgyoXyiU9BPt1hM=
X-Received: by 2002:a05:600c:1c0d:b0:3f4:255e:e375 with SMTP id
 j13-20020a05600c1c0d00b003f4255ee375mr420578wms.9.1685659544986; 
 Thu, 01 Jun 2023 15:45:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sh/ZIA0ZVIzXCmzdfA5uE5yGg4UsnJaJ+ajB3h8pERZITvdukhdpOx8NDS8EyTSsSwTGrWQ==
X-Received: by 2002:a05:600c:1c0d:b0:3f4:255e:e375 with SMTP id
 j13-20020a05600c1c0d00b003f4255ee375mr420568wms.9.1685659544625; 
 Thu, 01 Jun 2023 15:45:44 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 bg22-20020a05600c3c9600b003f4283f5c1bsm11243825wmb.2.2023.06.01.15.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 15:45:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 02/10] tests/qtest: add support for callback to
 receive QMP events
In-Reply-To: <20230601161347.1803440-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Jun 2023 17:13:39
 +0100")
References: <20230601161347.1803440-1-berrange@redhat.com>
 <20230601161347.1803440-3-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 00:45:42 +0200
Message-ID: <87sfbarecp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> Currently code must call one of the qtest_qmp_event* functions to
> fetch events. These are only usable if the immediate caller knows
> the particular event they want to capture, and are only interested
> in one specific event type. Adding ability to register an event
> callback lets the caller capture a range of events over any period
> of time.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


