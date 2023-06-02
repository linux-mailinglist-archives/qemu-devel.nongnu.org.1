Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3E71FB5F
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:52:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4zZH-0000yR-2z; Fri, 02 Jun 2023 03:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4zZE-0000xm-Op
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4zZC-0002xt-7s
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685692278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K18TlroRjGqv1Gmp07uKYoxP1D+ClHal2grnG4fZbiw=;
 b=RSgZ+4uY/n6mB6g7C+M9C3EweG+m3fWjKwm4WOvInWbC9c5auVVu8B9I246cBRdmijG7CN
 FvRVUZPGg0AJhu1U2CvSxLmw/qS3862n+tUZciEvY3Y6LsB2oRZ6nxvt0QMpvwMB1Xo18Z
 t9AvUIEb2YxRJbYMnGTXGTc+kWBvCoA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-NxPDTDdQNCyluluNYvI60w-1; Fri, 02 Jun 2023 03:51:17 -0400
X-MC-Unique: NxPDTDdQNCyluluNYvI60w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f6f2f18ecbso10103275e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 00:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685692276; x=1688284276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K18TlroRjGqv1Gmp07uKYoxP1D+ClHal2grnG4fZbiw=;
 b=N3MU0FTWukfK2Z23/m5U260/r3sSEEroJb5bG1PElAzF8/rMz5kMlsSM3BmIwFyWbO
 I9MLEwyzCEanVfgbeGoLgtmYZ0ESfnGWUKLhc91AbstaKojyKUkRL9G9H5pu9CTBIlJs
 0pkOxozKUoq6nRbx8GByBjG3+RJEc3UeUIZCwXPUaoFhl+qSsNp9njYtUCNP/YKloZmb
 cnqpJSNcH3gXZTmem6YnxDrsig/xwT5G8tqr/qELxlqVluz+JTBmZ3jOhTEdok1KgFCJ
 TeN96Afp7clrZE+yq+eSCZCuaLg2ACjvpV3twWu0lsB30uNd32y3+v6vWgYbrr9/Prji
 nfDw==
X-Gm-Message-State: AC+VfDyZaRh3CjrA/AEziccDCEJJFE56wCF90mpwf0pKzTheMnP1i4R+
 YOK/2TCDrPiJrYipAjo8d7VW1BFDP2y377g+AjZByHErayttob4Pa3XbMDtWMRchWvF5pTVJ4hC
 yoTZ0hU62m0LAIQc=
X-Received: by 2002:a7b:cc94:0:b0:3f6:a81:eb52 with SMTP id
 p20-20020a7bcc94000000b003f60a81eb52mr1304026wma.21.1685692276103; 
 Fri, 02 Jun 2023 00:51:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6J+mo+ToT5rAv8TqSZXAeMl3zx/Aqizpks3dISnUc6EqhIKAtGVxh3faKBrulcoUy62bJlHQ==
X-Received: by 2002:a7b:cc94:0:b0:3f6:a81:eb52 with SMTP id
 p20-20020a7bcc94000000b003f60a81eb52mr1304008wma.21.1685692275812; 
 Fri, 02 Jun 2023 00:51:15 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-14.web.vodafone.de.
 [109.43.176.14]) by smtp.gmail.com with ESMTPSA id
 u8-20020a7bc048000000b003f4b6bcbd8bsm1073429wmc.31.2023.06.02.00.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 00:51:15 -0700 (PDT)
Message-ID: <1febcf01-9891-acd9-f906-4a516bf54a1d@redhat.com>
Date: Fri, 2 Jun 2023 09:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/10] tests/qtest: add support for callback to receive
 QMP events
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20230601161347.1803440-1-berrange@redhat.com>
 <20230601161347.1803440-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601161347.1803440-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01/06/2023 18.13, Daniel P. Berrangé wrote:
> Currently code must call one of the qtest_qmp_event* functions to
> fetch events. These are only usable if the immediate caller knows
> the particular event they want to capture, and are only interested
> in one specific event type. Adding ability to register an event
> callback lets the caller capture a range of events over any period
> of time.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/libqtest.c | 18 ++++++++++++++++--
>   tests/qtest/libqtest.h | 43 ++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 57 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


