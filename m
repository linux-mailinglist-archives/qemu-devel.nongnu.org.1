Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 819879BB8F5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Nov 2024 16:27:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7yyR-0007Qm-I3; Mon, 04 Nov 2024 10:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7yy6-0007HU-6w
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7yy4-0002PC-LW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730733971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aXGygQRo4Y2J5leqSZjB/erKrl4zbAXATs/xPA+F5z8=;
 b=YiQx1xWs6ceWMlC7WvuqmU51P0wqz3kPq4do7T12PYQuogG0HwHWcG7IUGZZWdfufSd6bv
 +mU78pODMf/EtmdLdeDn/CIdTkwUunhME3uT9KqDFAaKs5srILgQkFejw6E3gQ934Zovtm
 Eo19x/c8bzZG+3Rl43P+33i6XTV2okg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-y-AzqxcCOOW9ps5kiFylng-1; Mon, 04 Nov 2024 10:26:09 -0500
X-MC-Unique: y-AzqxcCOOW9ps5kiFylng-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7181ca4eca5so3877986a34.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 07:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730733969; x=1731338769;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXGygQRo4Y2J5leqSZjB/erKrl4zbAXATs/xPA+F5z8=;
 b=Gbgg8JusSbXFZDGJtYRLy+Cwv87oF+qwt0Vtf32ua/eUtDCMMMlpo9c4hjJZ+iFLce
 9V8xi0bNv2sruh0A8LxwlRbqBwcJP+lwvhVtpm4zV1affZ0tiEhJjQKMJcmbhPhB5hZq
 gbFQvtunnOkwtQGeBbUTmsFXwfrM4V7prgyBylYHalzJRDPxrl+hGqvewQeW5spj5oeK
 LDVLYLEa1kXbHIe76+//FhSAUwErmO3Qj/FHqV2RYIkWQk/RjIs0PbX6GQ3OEci0KX+M
 Luu9p7aHawzYEKAXibe/pbZyfXpsi2QO7tl8YcaxiczXWYAgVA3pse3Us1DSV60WhwvC
 w+1A==
X-Gm-Message-State: AOJu0YyOaEensrbxFRWDCJd5/cqqbcDGSPKp/dnUVD4PCRRfj6sC6e31
 6luc5VevB6nPksu1A78aog2y3BcHTsdLfihFbBZ8bw25kFcr/pvnx8VmUU3jke1WjjlHKszbU3+
 5z5W66jlXStQDS3dpBWsYYx0Y+hX51N1ISaYErXQFPOpOFCHZdIm4
X-Received: by 2002:a05:6830:4492:b0:717:f7b9:e159 with SMTP id
 46e09a7af769-71868281e8cmr27373091a34.20.1730733969023; 
 Mon, 04 Nov 2024 07:26:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFULAoxg8sPBOr3pVml0nxEpyeCkKFQBzgpUCFh00sLqj1f84UPqwt8XbPBC8phDuOSHIRiZg==
X-Received: by 2002:a05:6830:4492:b0:717:f7b9:e159 with SMTP id
 46e09a7af769-71868281e8cmr27373059a34.20.1730733968599; 
 Mon, 04 Nov 2024 07:26:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7189cc69cf6sm2004499a34.26.2024.11.04.07.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 07:26:08 -0800 (PST)
Message-ID: <6da54e4b-e8ef-4af3-9006-8fad58d97438@redhat.com>
Date: Mon, 4 Nov 2024 16:26:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] migration: Protect updates to current_migration
 with a mutex
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-9-peterx@redhat.com>
 <ac9645b9-e188-4f8c-87bb-abaa9da12c74@redhat.com> <Zx-yra1XrsUxnEk-@x1n>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Zx-yra1XrsUxnEk-@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 10/28/24 16:50, Peter Xu wrote:
> On Fri, Oct 25, 2024 at 02:50:36PM +0200, Cédric Le Goater wrote:
>> On 10/24/24 23:30, Peter Xu wrote:
>>> Introduce migration_mutex, protecting concurrent updates to
>>> current_migration.
>>>
>>> In reality, most of the exported migration functions are safe to access
>>> migration objects on capabilities, etc., e.g. many of the code is invoked
>>> within migration thread via different hooks (e.g., precopy notifier,
>>> vmstate handler hooks, etc.).
>>>
>>> So literally the mutex so far only makes sure below two APIs that are prone
>>> to accessing freed current_migration:
>>>
>>>           migration_is_running()
>>>           migration_file_set_error()
>>>
>>> Then we'll need to take the mutex too when init/free the migration object.
>>
>> we should also drop :
>>
>>    static void vfio_set_migration_error(int ret)
>>    {
>>        if (migration_is_running()) {
>>            migration_file_set_error(ret, NULL);
>>        }
>>    }
>>
>> and use directly migration_file_set_error().
> 
> We'll need to export migration_is_running() anyway, though.  So maybe we
> can do that as a VFIO's follow up?

sure. Let's add that to the list, along with the 'log_enabled' bool that
you discussed with Avihai in the previous patch :

  [PATCH v3 7/8] migration: Unexport migration_is_active()

These changes would be good to have in QEMU 9.2.

Avihai, I have access to HW supporting HW dirty tracking.

Thanks,

C.


