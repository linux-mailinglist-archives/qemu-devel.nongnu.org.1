Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDA18B3E32
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Apr 2024 19:32:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PQB-0005RN-KO; Fri, 26 Apr 2024 13:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s0PQ8-0005Q4-DI
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:31:37 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s0PQ4-00052F-RS
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:31:36 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so20148015ad.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714152691; x=1714757491; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RjoyRptJmwyYwHaJWxeJSuDfaWK8yqZJ7QWAv8TCjoA=;
 b=eC9zXyETKOutRp8a8BoSqbbdS7VrNFBosf8migjsb1u6MgvOd9wS/9sNxH37enBkZa
 Krmu7FZxOqnyPm/hPFqrD61UFcUPHn5zEX5axgEZusD0HfAPMvXXOst43n3KyaOcF6pJ
 mRicqtyl30KZctnCui5LoMVYbptlQ8jDUSxmLiDlebo/l1pLAWmj3ZaL6Xb7N86lyNpH
 Uyk+ai4dwUyPNwFp7o2Ukl7J9bhwdhOFm1YILkyWHfTha0jI/CTqqM7v5CIftNZzgezz
 cqsmmSE2LPNbcmv+HKrID9aFnv4HaFP8eLAAPf8lKrXLzrSCh9hrj1PFAr8LZiu00cXw
 2rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714152691; x=1714757491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjoyRptJmwyYwHaJWxeJSuDfaWK8yqZJ7QWAv8TCjoA=;
 b=kMPxs8rTcsNR6lu4hAWKfCuTTP6uf150Hj4EQ9MBkpLcUeGYzm7sGTyGrznnASrZ19
 +jq4XiuqGVYEMOgznkYcihbWDA0OEhRvkxoWj2A9ZLBAO+D5VkxhyTr6dxlx6S26Ek3n
 jeLusgH+EWQSWD0Hq0wOJDjLY6LmdIbqSSgqBY9bOMsAYT/8FipW3yKb0COasaS9sClG
 0dVUZehLAJKXlwiBWM4hZEiGIjjMznnVD7O922MUQT+bzqlkUpwsZIxBMfk1V5cgVC3O
 ZYRDoHpZ8KK10jF/23//6nLRT1oCBoLL0VSxngAj6K7YBN3J9qJCWYVF9BUZIy9rZ+3L
 6JvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkMZMYDVBH6RUPeL0xXg2u1OHuwtjp2zvd7SeYDUfzMki8BGqUwsWgv3q7zQ+qudFdKZF4rtQ0lbNjI/ab9YaiFdYxp0I=
X-Gm-Message-State: AOJu0YxY4sF3/CwBZR1M7SV/7LgBBx/TYBZtdaKHNx+j0cRXxa6fyAuO
 MOvbFbkKamaFZnpUNUsy9MOUuuu3os6QGVhiO6S+Ixf5vZZIyd9AP7NTKQ==
X-Google-Smtp-Source: AGHT+IEqKlv59Qh8SzrVuY0BQCoi4ol7G0SWhguctvSMG45wnBqw9+p1/bX3I9liRm2RWMGphjSm1g==
X-Received: by 2002:a17:902:6804:b0:1e2:7dc7:477 with SMTP id
 h4-20020a170902680400b001e27dc70477mr2950050plk.57.1714152690425; 
 Fri, 26 Apr 2024 10:31:30 -0700 (PDT)
Received: from debian ([2601:641:300:14de:8131:2f0f:7518:2552])
 by smtp.gmail.com with ESMTPSA id
 bi2-20020a170902bf0200b001e27ad5199csm15677175plb.281.2024.04.26.10.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 10:31:30 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 26 Apr 2024 10:31:11 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <Zivk37xBGPsL_yo5@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cgkxzal.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 26, 2024 at 11:12:50AM +0200, Markus Armbruster wrote:
> nifan.cxl@gmail.com writes:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > To simulate FM functionalities for initiating Dynamic Capacity Add
> > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> > r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> > add/release dynamic capacity extents requests.
> >
> > With the change, we allow to release an extent only when its DPA range
> > is contained by a single accepted extent in the device. That is to say,
> > extent superset release is not supported yet.
> >
> > 1. Add dynamic capacity extents:
> >
> > For example, the command to add two continuous extents (each 128MiB long)
> > to region 0 (starting at DPA offset 0) looks like below:
> >
> > { "execute": "qmp_capabilities" }
> >
> > { "execute": "cxl-add-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "hid": 0,
> >       "selection-policy": 2,
> >       "region-id": 0,
> >       "tag": "",
> >       "extents": [
> >       {
> >           "offset": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > 2. Release dynamic capacity extents:
> >
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) looks like below:
> >
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "hid": 0,
> >       "flags": 1,
> >       "region-id": 0,
> >       "tag": "",
> >       "extents": [
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  62 +++++--
> >  hw/mem/cxl_type3.c          | 311 +++++++++++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3_stubs.c    |  20 +++
> >  include/hw/cxl/cxl_device.h |  22 +++
> >  include/hw/cxl/cxl_events.h |  18 +++
> >  qapi/cxl.json               |  69 ++++++++
> >  6 files changed, 489 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 9d54e10cd4..3569902e9e 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1405,7 +1405,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> >   * Check whether any bit between addr[nr, nr+size) is set,
> >   * return true if any bit is set, otherwise return false
> >   */
> > -static bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> > +bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> >                                unsigned long size)
> >  {
> >      unsigned long res = find_next_bit(addr, size + nr, nr);
> > @@ -1444,7 +1444,7 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
> >      return NULL;
> >  }
> >  
> > -static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
> > +void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
> >                                               uint64_t dpa,
> >                                               uint64_t len,
> >                                               uint8_t *tag,
> > @@ -1470,6 +1470,44 @@ void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> >      g_free(extent);
> >  }
> >  
> > +/*
> > + * Add a new extent to the extent "group" if group exists;
> > + * otherwise, create a new group
> > + * Return value: return the group where the extent is inserted.
> > + */
> > +CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
> > +                                                    uint64_t dpa,
> > +                                                    uint64_t len,
> > +                                                    uint8_t *tag,
> > +                                                    uint16_t shared_seq)
> > +{
> > +    if (!group) {
> > +        group = g_new0(CXLDCExtentGroup, 1);
> > +        QTAILQ_INIT(&group->list);
> > +    }
> > +    cxl_insert_extent_to_extent_list(&group->list, dpa, len,
> > +                                     tag, shared_seq);
> > +    return group;
> > +}
> > +
> > +void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
> > +                                       CXLDCExtentGroup *group)
> > +{
> > +    QTAILQ_INSERT_TAIL(list, group, node);
> > +}
> > +
> > +void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> > +{
> > +    CXLDCExtent *ent, *ent_next;
> > +    CXLDCExtentGroup *group = QTAILQ_FIRST(list);
> > +
> > +    QTAILQ_REMOVE(list, group, node);
> > +    QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
> > +        cxl_remove_extent_from_extent_list(&group->list, ent);
> > +    }
> > +    g_free(group);
> > +}
> > +
> >  /*
> >   * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
> >   * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
> > @@ -1541,6 +1579,7 @@ static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
> >  {
> >      uint32_t i;
> >      CXLDCExtent *ent;
> > +    CXLDCExtentGroup *ext_group;
> >      uint64_t dpa, len;
> >      Range range1, range2;
> >  
> > @@ -1551,9 +1590,13 @@ static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
> >          range_init_nofail(&range1, dpa, len);
> >  
> >          /*
> > -         * TODO: once the pending extent list is added, check against
> > -         * the list will be added here.
> > +         * The host-accepted DPA range must be contained by the first extent
> > +         * group in the pending list
> >           */
> > +        ext_group = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > +        if (!cxl_extents_contains_dpa_range(&ext_group->list, dpa, len)) {
> > +            return CXL_MBOX_INVALID_PA;
> > +        }
> >  
> >          /* to-be-added range should not overlap with range already accepted */
> >          QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> > @@ -1586,10 +1629,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      CXLRetCode ret;
> >  
> >      if (in->num_entries_updated == 0) {
> > -        /*
> > -         * TODO: once the pending list is introduced, extents in the beginning
> > -         * will get wiped out.
> > -         */
> > +        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> >          return CXL_MBOX_SUCCESS;
> >      }
> >  
> > @@ -1615,11 +1655,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >  
> >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> >          ct3d->dc.total_extent_count += 1;
> > -        /*
> > -         * TODO: we will add a pending extent list based on event log record
> > -         * and process the list accordingly here.
> > -         */
> >      }
> > +    /* Remove the first extent group in the pending list*/
> > +    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> >  
> >      return CXL_MBOX_SUCCESS;
> >  }
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index c2cdd6d506..e892b3de7b 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -667,6 +667,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >          ct3d->dc.total_capacity += region->len;
> >      }
> >      QTAILQ_INIT(&ct3d->dc.extents);
> > +    QTAILQ_INIT(&ct3d->dc.extents_pending);
> >  
> >      return true;
> >  }
> > @@ -674,10 +675,19 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >  static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> >  {
> >      CXLDCExtent *ent, *ent_next;
> > +    CXLDCExtentGroup *group, *group_next;
> >  
> >      QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
> >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> >      }
> > +
> > +    QTAILQ_FOREACH_SAFE(group, &ct3d->dc.extents_pending, node, group_next) {
> > +        QTAILQ_REMOVE(&ct3d->dc.extents_pending, group, node);
> > +        QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
> > +            cxl_remove_extent_from_extent_list(&group->list, ent);
> > +        }
> > +        g_free(group);
> > +    }
> >  }
> >  
> >  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> > @@ -1443,7 +1453,6 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
> >          return CXL_EVENT_TYPE_FAIL;
> >      case CXL_EVENT_LOG_FATAL:
> >          return CXL_EVENT_TYPE_FATAL;
> > -/* DCD not yet supported */
> >      default:
> >          return -EINVAL;
> >      }
> > @@ -1694,6 +1703,306 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> >      }
> >  }
> >  
> > +/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> > +static const QemuUUID dynamic_capacity_uuid = {
> > +    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> > +                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> > +};
> > +
> > +typedef enum CXLDCEventType {
> > +    DC_EVENT_ADD_CAPACITY = 0x0,
> > +    DC_EVENT_RELEASE_CAPACITY = 0x1,
> > +    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> > +    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> > +    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> > +    DC_EVENT_CAPACITY_RELEASED = 0x5,
> > +} CXLDCEventType;
> > +
> > +/*
> > + * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
> > + * the list.
> > + * Return value: return true if has overlaps; otherwise, return false
> > + */
> > +static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                           uint64_t dpa, uint64_t len)
> > +{
> > +    CXLDCExtent *ent;
> > +    Range range1, range2;
> > +
> > +    if (!list) {
> > +        return false;
> > +    }
> > +
> > +    range_init_nofail(&range1, dpa, len);
> > +    QTAILQ_FOREACH(ent, list, node) {
> > +        range_init_nofail(&range2, ent->start_dpa, ent->len);
> > +        if (range_overlaps_range(&range1, &range2)) {
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> > +/*
> > + * Check whether the range [dpa, dpa + len - 1] is contained by extents in
> > + * the list.
> > + * Will check multiple extents containment once superset release is added.
> > + * Return value: return true if range is contained; otherwise, return false
> > + */
> > +bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len)
> > +{
> > +    CXLDCExtent *ent;
> > +    Range range1, range2;
> > +
> > +    if (!list) {
> > +        return false;
> > +    }
> > +
> > +    range_init_nofail(&range1, dpa, len);
> > +    QTAILQ_FOREACH(ent, list, node) {
> > +        range_init_nofail(&range2, ent->start_dpa, ent->len);
> > +        if (range_contains_range(&range2, &range1)) {
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> > +static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                                uint64_t dpa, uint64_t len)
> > +{
> > +    CXLDCExtentGroup *group;
> > +
> > +    if (!list) {
> > +        return false;
> > +    }
> > +
> > +    QTAILQ_FOREACH(group, list, node) {
> > +        if (cxl_extents_overlaps_dpa_range(&group->list, dpa, len)) {
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> > +/*
> > + * The main function to process dynamic capacity event with extent list.
> > + * Currently DC extents add/release requests are processed.
> > + */
> > +static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
> > +        uint16_t hid, CXLDCEventType type, uint8_t rid,
> > +        CXLDCExtentRecordList *records, Error **errp)
> > +{
> > +    Object *obj;
> > +    CXLEventDynamicCapacity dCap = {};
> > +    CXLEventRecordHdr *hdr = &dCap.hdr;
> > +    CXLType3Dev *dcd;
> > +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> > +    uint32_t num_extents = 0;
> > +    CXLDCExtentRecordList *list;
> > +    CXLDCExtentGroup *group = NULL;
> > +    g_autofree CXLDCExtentRaw *extents = NULL;
> > +    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
> > +    uint64_t dpa, offset, len, block_size;
> > +    g_autofree unsigned long *blk_bitmap = NULL;
> > +    int i;
> > +
> > +    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
> > +    if (!obj) {
> > +        error_setg(errp, "Unable to resolve CXL type 3 device");
> > +        return;
> > +    }
> > +
> > +    dcd = CXL_TYPE3(obj);
> > +    if (!dcd->dc.num_regions) {
> > +        error_setg(errp, "No dynamic capacity support from the device");
> > +        return;
> > +    }
> > +
> > +
> > +    if (rid >= dcd->dc.num_regions) {
> > +        error_setg(errp, "region id is too large");
> > +        return;
> > +    }
> > +    block_size = dcd->dc.regions[rid].block_size;
> > +    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
> > +
> > +    /* Sanity check and count the extents */
> > +    list = records;
> > +    while (list) {
> > +        offset = list->value->offset;
> > +        len = list->value->len;
> > +        dpa = offset + dcd->dc.regions[rid].base;
> > +
> > +        if (len == 0) {
> > +            error_setg(errp, "extent with 0 length is not allowed");
> > +            return;
> > +        }
> > +
> > +        if (offset % block_size || len % block_size) {
> > +            error_setg(errp, "dpa or len is not aligned to region block size");
> > +            return;
> > +        }
> > +
> > +        if (offset + len > dcd->dc.regions[rid].len) {
> > +            error_setg(errp, "extent range is beyond the region end");
> > +            return;
> > +        }
> > +
> > +        /* No duplicate or overlapped extents are allowed */
> > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > +                              len / block_size)) {
> > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > +            return;
> > +        }
> > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > +
> > +        if (type == DC_EVENT_RELEASE_CAPACITY) {
> > +            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
> > +                                                     dpa, len)) {
> > +                error_setg(errp,
> > +                           "cannot release extent with pending DPA range");
> > +                return;
> > +            }
> > +            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
> > +                error_setg(errp,
> > +                           "cannot release extent with non-existing DPA range");
> > +                return;
> > +            }
> > +        } else if (type == DC_EVENT_ADD_CAPACITY) {
> > +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents, dpa, len)) {
> > +                error_setg(errp,
> > +                           "cannot add DPA already accessible  to the same LD");
> > +                return;
> > +            }
> > +            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
> > +                                                     dpa, len)) {
> > +                error_setg(errp,
> > +                           "cannot add DPA again while still pending");
> > +                return;
> > +            }
> > +        }
> > +        list = list->next;
> > +        num_extents++;
> > +    }
> > +
> > +    /* Create extent list for event being passed to host */
> > +    i = 0;
> > +    list = records;
> > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > +    while (list) {
> > +        offset = list->value->offset;
> > +        len = list->value->len;
> > +        dpa = dcd->dc.regions[rid].base + offset;
> > +
> > +        extents[i].start_dpa = dpa;
> > +        extents[i].len = len;
> > +        memset(extents[i].tag, 0, 0x10);
> > +        extents[i].shared_seq = 0;
> > +        if (type == DC_EVENT_ADD_CAPACITY) {
> > +            group = cxl_insert_extent_to_extent_group(group,
> > +                                                      extents[i].start_dpa,
> > +                                                      extents[i].len,
> > +                                                      extents[i].tag,
> > +                                                      extents[i].shared_seq);
> > +        }
> > +
> > +        list = list->next;
> > +        i++;
> > +    }
> > +    if (group) {
> > +        cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
> > +    }
> > +
> > +    /*
> > +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> > +     *
> > +     * All Dynamic Capacity event records shall set the Event Record Severity
> > +     * field in the Common Event Record Format to Informational Event. All
> > +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> > +     * Event Log.
> > +     */
> > +    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> > +                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> > +
> > +    dCap.type = type;
> > +    /* FIXME: for now, validity flag is cleared */
> > +    dCap.validity_flags = 0;
> > +    stw_le_p(&dCap.host_id, hid);
> > +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> > +    dCap.updated_region_id = 0;
> > +    dCap.flags = 0;
> > +    for (i = 0; i < num_extents; i++) {
> > +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> > +               sizeof(CXLDCExtentRaw));
> > +
> > +        if (i < num_extents - 1) {
> > +            /* Set "More" flag */
> > +            dCap.flags |= BIT(0);
> > +        }
> > +
> > +        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> > +                             (CXLEventRecordRaw *)&dCap)) {
> > +            cxl_event_irq_assert(dcd);
> > +        }
> > +    }
> > +}
> > +
> > +void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t hid,
> > +                                  uint8_t sel_policy, uint8_t region_id,
> > +                                  const char *tag,
> > +                                  CXLDCExtentRecordList  *records,
> > +                                  Error **errp)
> > +{
> > +    enum {
> > +        CXL_SEL_POLICY_FREE,
> > +        CXL_SEL_POLICY_CONTIGUOUS,
> > +        CXL_SEL_POLICY_PRESCRIPTIVE,
> > +        CXL_SEL_POLICY_ENABLESHAREDACCESS,
> > +    };
> > +    switch (sel_policy) {
> > +    case CXL_SEL_POLICY_PRESCRIPTIVE:
> > +        qmp_cxl_process_dynamic_capacity_prescriptive(path, hid,
> > +                                                      DC_EVENT_ADD_CAPACITY,
> > +                                                      region_id, records, errp);
> > +        return;
> > +    default:
> > +        error_setg(errp, "Selection policy not supported");
> > +        return;
> > +    }
> > +}
> > +
> > +#define REMOVAL_POLICY_MASK 0xf
> > +#define REMOVAL_POLICY_PRESCRIPTIVE 1
> > +#define FORCED_REMOVAL_BIT BIT(4)
> > +
> > +void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t hid,
> > +                                      uint8_t flags, uint8_t region_id,
> > +                                      const char *tag,
> > +                                      CXLDCExtentRecordList  *records,
> > +                                      Error **errp)
> > +{
> > +    CXLDCEventType type = DC_EVENT_RELEASE_CAPACITY;
> > +
> > +    if (flags & FORCED_REMOVAL_BIT) {
> > +        /* TODO: enable forced removal in the future */
> > +        type = DC_EVENT_FORCED_RELEASE_CAPACITY;
> > +        error_setg(errp, "Forced removal not supported yet");
> > +        return;
> > +    }
> > +
> > +    switch (flags & REMOVAL_POLICY_MASK) {
> > +    case REMOVAL_POLICY_PRESCRIPTIVE:
> > +        qmp_cxl_process_dynamic_capacity_prescriptive(path, hid, type,
> > +                                                      region_id, records, errp);
> > +        return;
> > +    default:
> > +        error_setg(errp, "Removal policy not supported");
> > +        return;
> > +    }
> > +}
> > +
> >  static void ct3_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(oc);
> > diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> > index 3e1851e32b..810685e0d5 100644
> > --- a/hw/mem/cxl_type3_stubs.c
> > +++ b/hw/mem/cxl_type3_stubs.c
> > @@ -67,3 +67,23 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
> >  {
> >      error_setg(errp, "CXL Type 3 support is not compiled in");
> >  }
> > +
> > +void qmp_cxl_add_dynamic_capacity(const char *path,
> > +                                  uint16_t hid,
> > +                                  uint8_t sel_policy,
> > +                                  uint8_t region_id,
> > +                                  const char *tag,
> > +                                  CXLDCExtentRecordList  *records,
> > +                                  Error **errp)
> > +{
> > +    error_setg(errp, "CXL Type 3 support is not compiled in");
> > +}
> > +
> > +void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t hid,
> > +                                      uint8_t flags, uint8_t region_id,
> > +                                      const char *tag,
> > +                                      CXLDCExtentRecordList  *records,
> > +                                      Error **errp)
> > +{
> > +    error_setg(errp, "CXL Type 3 support is not compiled in");
> > +}
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index df3511e91b..c69ff6b5de 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -443,6 +443,12 @@ typedef struct CXLDCExtent {
> >  } CXLDCExtent;
> >  typedef QTAILQ_HEAD(, CXLDCExtent) CXLDCExtentList;
> >  
> > +typedef struct CXLDCExtentGroup {
> > +    CXLDCExtentList list;
> > +    QTAILQ_ENTRY(CXLDCExtentGroup) node;
> > +} CXLDCExtentGroup;
> > +typedef QTAILQ_HEAD(, CXLDCExtentGroup) CXLDCExtentGroupList;
> > +
> >  typedef struct CXLDCRegion {
> >      uint64_t base;       /* aligned to 256*MiB */
> >      uint64_t decode_len; /* aligned to 256*MiB */
> > @@ -494,6 +500,7 @@ struct CXLType3Dev {
> >           */
> >          uint64_t total_capacity; /* 256M aligned */
> >          CXLDCExtentList extents;
> > +        CXLDCExtentGroupList extents_pending;
> >          uint32_t total_extent_count;
> >          uint32_t ext_list_gen_seq;
> >  
> > @@ -555,4 +562,19 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
> >  
> >  void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> >                                          CXLDCExtent *extent);
> > +void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
> > +                                      uint64_t len, uint8_t *tag,
> > +                                      uint16_t shared_seq);
> > +bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> > +                       unsigned long size);
> > +bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len);
> > +CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
> > +                                                    uint64_t dpa,
> > +                                                    uint64_t len,
> > +                                                    uint8_t *tag,
> > +                                                    uint16_t shared_seq);
> > +void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
> > +                                       CXLDCExtentGroup *group);
> > +void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
> >  #endif
> > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > index 5170b8dbf8..38cadaa0f3 100644
> > --- a/include/hw/cxl/cxl_events.h
> > +++ b/include/hw/cxl/cxl_events.h
> > @@ -166,4 +166,22 @@ typedef struct CXLEventMemoryModule {
> >      uint8_t reserved[0x3d];
> >  } QEMU_PACKED CXLEventMemoryModule;
> >  
> > +/*
> > + * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
> > + * All fields little endian.
> > + */
> > +typedef struct CXLEventDynamicCapacity {
> > +    CXLEventRecordHdr hdr;
> > +    uint8_t type;
> > +    uint8_t validity_flags;
> > +    uint16_t host_id;
> > +    uint8_t updated_region_id;
> > +    uint8_t flags;
> > +    uint8_t reserved2[2];
> > +    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
> > +    uint8_t reserved[0x18];
> > +    uint32_t extents_avail;
> > +    uint32_t tags_avail;
> > +} QEMU_PACKED CXLEventDynamicCapacity;
> > +
> >  #endif /* CXL_EVENTS_H */
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 4281726dec..2dcf03d973 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -361,3 +361,72 @@
> >  ##
> >  {'command': 'cxl-inject-correctable-error',
> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> > +
> > +##
> > +# @CXLDCExtentRecord:
> 
> Such traffic jams of capital letters are hard to read.  What about
> CxlDynamicCapacityExtent?
> 
> > +#
> > +# Record of a single extent to add/release
> 
> Suggest "A dynamic capacity extent."
> 
> > +#
> > +# @offset: offset to the start of the region where the extent to be operated
> 
> Blank line here, please.
> 
> 
> 
> > +# @len: length of the extent
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'CXLDCExtentRecord',
> > +  'data': {
> > +      'offset':'uint64',
> > +      'len': 'uint64'
> > +  }
> > +}
> > +
> > +##
> > +# @cxl-add-dynamic-capacity:
> > +#
> > +# Command to start add dynamic capacity extents flow. The device will
> > +# have to acknowledged the acceptance of the extents before they are usable.
> 
> This text needs work.  More on that at the end of my review.

Yes. I will work on it for the next version once all the feedbacks
are collected and comments are resolved.

See below.

> 
> docs/devel/qapi-code-gen.rst:
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.
> 
> More elsewhere.
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> 
> I'd prefer @qom-path, unless you can make a consistency argument for
> @path.
> 
> Sure the QOM path needs to be canonical?
> 
> If not, what about "path to the CXL dynamic capacity device in the QOM
> tree".  Intentionally close to existing descriptions of @qom-path
> elsewhere.

From the same file, I saw "path" was used for other commands, like
"cxl-inject-memory-module-event", so I followed it.
DCD is nothing different from "type 3 device" expect it can dynamically
change capacity. 
Renaming it to "qom-path" is no problem for me, just want to make sure it
will not break the naming consistency.

> 
> > +# @hid: host id
> 
> @host-id, unless "HID" is established terminology in CXL DCD land.

host-id works.
> 
> What is a host ID?

It is an id identifying the host to which the capacity is being added.

> 
> > +# @selection-policy: policy to use for selecting extents for adding capacity
> 
> Where are selection policies defined?

It is defined in CXL specification: Specifies the policy to use for selecting
which extents comprise the added capacity

> 
> > +# @region-id: id of the region where the extent to add
> 
> Is "region ID" the established terminology in CXL DCD land?  Or is
> "region number" also used?  I'm asking because "ID" in this QEMU device
> context suggests a connection to a qdev ID.
> 
> If region number is fine, I'd rename to just @region, and rephrase the
> description to avoid "ID".  Perhaps "number of the region the extent is
> to be added to".  Not entirely happy with the phrasing, doesn't exactly
> roll off the tongue, but "where the extent to add" sounds worse to my
> ears.  Mind, I'm not a native speaker.

Yes. region number is fine. Will rename it as "region"

> 
> > +# @tag: Context field
> 
> What is this about?

Based on the specification, it is "Context field utilized by implementations
that make use of the Dynamic Capacity feature.". Basically, it is a
string (label) attached to an dynamic capacity extent so we can achieve
specific purpose, like identifying or grouping extents.

> 
> > +# @extents: Extents to add
> 
> Blank lines between argument descriptions, please.
> 
> > +#
> > +# Since : 9.1
> > +##
> > +{ 'command': 'cxl-add-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'hid': 'uint16',
> > +            'selection-policy': 'uint8',
> > +            'region-id': 'uint8',
> > +            'tag': 'str',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to start release dynamic capacity extents flow. The host will
> > +# need to respond to indicate that it has released the capacity before it
> > +# is made unavailable for read and write and can be re-added.
> 
> This text needs work.  More on that at the end of my review.

Will do.

> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> 
> My comment on cxl-add-dynamic-capacity applies.
> 
> > +# @hid: host id
> 
> Likewise.
> 
> > +# @flags: bit[3:0] for removal policy, bit[4] for forced removal, bit[5] for
> > +#     sanitize on release, bit[7:6] reserved
> 
> Where are these flags defined?

Defined in the CXL specification, it defines the release behaviour.

> 
> > +# @region-id: id of the region where the extent to release
> 
> My comment on cxl-add-dynamic-capacity applies.
> 
> > +# @tag: Context field
> 
> Likewise.
> 
> > +# @extents: Extents to release
> > +#
> > +# Since : 9.1
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'hid': 'uint16',
> > +            'flags': 'uint8',
> > +            'region-id': 'uint8',
> > +            'tag': 'str',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> 
> During review of v5, you wrote:
> 
>     For add command, the host will send a mailbox command to response to
>     the add request to the device to indicate whether it accepts the add
>     capacity offer or not.
>     
>     For release command, the host send a mailbox command (not always a
>     response since the host can proactively release capacity if it does
>     not need it any more) to device to ask device release the capacity.
> 
> Can you briefly sketch the protocol?  Peers and messages involved.
> Possibly as a state diagram.

Need to think about it. If we can polish the text nicely, maybe the
sketch is not needed. My concern is that the sketch may
introduce unwanted complexity as we expose too much details. The two
commands provide ways to add/release dynamic capacity to/from a host,
that is all. All the other information, like what the host will do, or
how the device will react, are consequence of the command, not sure
whether we want to include here.

@Jonathan, Any thoughts on this?

Fan

> 

