Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCAE81ED05
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 08:52:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIOgh-0008OF-Ja; Wed, 27 Dec 2023 02:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rIOgZ-0008Nn-Vh
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 02:50:41 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rIOgW-0008K7-6X
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 02:50:39 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id DE23B40DFC
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1703663431;
 bh=zzIxHJrNYRWZfoE/ca28yUtRqFKFhsjlJoMYzODSuvg=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=pQOA2KnDObbB2WlbXxd/jCmfPRIV8M1pWHWIavPZsMdk/xwbQXp6Rc5+44dqkREF2
 agEZ0XzmGH06KHV9hRcpkglUpbt8KwNnMT8WgtnNhxaxhAx5EZPXZfOlZ7TTyLWL1U
 N8PQcWE4FROnyhvfVCDq96dLNd4CBo//NLInjouO/TdrIuxaXTdkiPmOPm0Y2UZ8UE
 EGXSUDNDuPIHNiR1t7XwO4quJi0VzMO9ytZ6rvOSgWrMZMnzlskQP3+LiRlarUuUuy
 F2VDvtGiJwmckWQTsZGNqUNzZAvIhV1xX7JZYtpmeo52XMl0L+ymfAAckIcnhmfyTT
 JiBNoDDUKmGNg==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 C98D7821D9
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 07:50:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Dec 2023 07:41:03 -0000
From: Not Applicable <1119281@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cyberbeastie fgouget janitor notapplicable623
 stefanha th-huth
X-Launchpad-Bug-Reporter: Francois Gouget (fgouget)
X-Launchpad-Bug-Modifier: Not Applicable (notapplicable623)
References: <20130208104503.10940.77009.malonedeb@chaenomeles.canonical.com>
Message-Id: <170366286360.632417.4702608155764620685.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 1119281] Re: The virtio network device breaks
 UuidCreateSequential()
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b";
 Instance="launchpad-scripts"
X-Launchpad-Hash: dc077fa0552c8831e2eabdfc7617a78c29db38d0
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1119281 <1119281@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The issue is still there in 2023.
Well since XP's source code had been leaked. I've gone through the source c=
ode and may have found the cause.

Nowadays UuidCreateSequential should use MAC address when available.
Here I quoted from the link below:
"For security reasons, UuidCreate was modified so that it no longer uses a =
machine's MAC address to generate UUIDs. UuidCreateSequential was introduce=
d to allow creation of UUIDs using the MAC address of a machine's Ethernet =
card."
https://learn.microsoft.com/en-us/windows/win32/api/rpcdce/nf-rpcdce-uuidcr=
eatesequential

Now let take a look at XP's code:
UuidCreateSequential() in dceuuid.cxx:
https://github.com/tongzx/nt5src/blob/daad8a087a4e75422ec96b7911f1df4669989=
611/Source/XPSP1/NT/com/rpc/runtime/mtrt/dceuuid.cxx#L122

RPC_STATUS RPC_ENTRY
UuidCreateSequential (
    OUT UUID PAPI * Uuid
    )
/*++

Routine Description:

    This routine will create a new UUID (or GUID) which is unique in
    time and space.  We will try to guarantee that the UUID (or GUID)
    we generate is unique in time and space.  This means that this
    routine may fail if we can not generate one which we can guarantee
    is unique in time and space.

Arguments:

    Uuid - Returns the generated UUID (or GUID).

Return Value:

    RPC_S_OK - The operation completed successfully.

    RPC_S_UUID_NO_ADDRESS - We were unable to obtain the ethernet or
        token ring address for this machine.

    RPC_S_UUID_LOCAL_ONLY - On NT & Chicago if we can't get a
        network address.  This is a warning to the user, the
        UUID is still valid, it just may not be unique on other machines.

    RPC_S_OUT_OF_MEMORY - Returned as needed.
--*/
{
    RPC_UUID_GENERATE PAPI * RpcUuid =3D (RPC_UUID_GENERATE PAPI *) Uuid;
    RPC_STATUS Status =3D RPC_S_OK;
    static DWORD LastTickCount =3D 0;

    InitializeIfNecessary();

    if (GetTickCount()-LastTickCount > MAX_CACHED_UUID_TIME)
        {
        UuidCachedValues.AllocatedCount =3D 0;
        LastTickCount =3D GetTickCount();
        }

    ULARGE_INTEGER Time;
    long Delta;

    for(;;)
        {
        Time.QuadPart =3D UuidCachedValues.Time.QuadPart;

        // Copy the static info into the UUID.  We can't do this later
        // because the clock sequence could be updated by another thread.

        *(unsigned long *)&RpcUuid->ClockSeqHiAndReserved =3D
            *(unsigned long *)&UuidCachedValues.ClockSeqHiAndReserved;
        *(unsigned long *)&RpcUuid->NodeId[2] =3D
            *(unsigned long *)&UuidCachedValues.NodeId[2];

        Delta =3D InterlockedDecrement(&UuidCachedValues.AllocatedCount);

        if (Time.QuadPart !=3D UuidCachedValues.Time.QuadPart)
            {
            // If our captured time doesn't match the cache then another
            // thread already took the lock and updated the cache. We'll
            // just loop and try again.
            continue;
            }

        if (Delta >=3D 0)
            {
            break;
            }

        //
        // Allocate block of Uuids.
        //

        Status =3D UuidGetValues( &UuidCachedValues );
        if (Status =3D=3D RPC_S_OK)
            {
            UuidCacheValid =3D CACHE_VALID;
            }
        else
            {
            UuidCacheValid =3D CACHE_LOCAL_ONLY;
            }

        if (Status !=3D RPC_S_OK
            && Status !=3D RPC_S_UUID_LOCAL_ONLY)
            {
#ifdef DEBUGRPC
            if (Status !=3D RPC_S_OUT_OF_MEMORY)
                PrintToDebugger("RPC: UuidGetValues returned or raised: %x\=
n", Status);
#endif
            ASSERT( (Status =3D=3D RPC_S_OUT_OF_MEMORY) );


            return Status;
            }

        // Loop
        }


    Time.QuadPart -=3D Delta;

    RpcUuid->TimeLow =3D (unsigned long) Time.LowPart;
    RpcUuid->TimeMid =3D (unsigned short) (Time.HighPart & 0x0000FFFF);
    RpcUuid->TimeHiAndVersion =3D (unsigned short)
        (( (unsigned short)(Time.HighPart >> 16)
        & RPC_UUID_TIME_HIGH_MASK) | RPC_UUID_VERSION);

    ASSERT(   Status =3D=3D RPC_S_OK
           || Status =3D=3D RPC_S_UUID_LOCAL_ONLY);

    if (UuidCacheValid =3D=3D CACHE_LOCAL_ONLY)
        {
        return RPC_S_UUID_LOCAL_ONLY;
        }

    return(Status);
}

UuidGetValues() in uuidsup.cxx:
https://github.com/tongzx/nt5src/blob/daad8a087a4e75422ec96b7911f1df4669989=
611/Source/XPSP1/NT/com/rpc/runtime/mtrt/uuidsup.cxx#L43

UuidGetValues(
    OUT UUID_CACHED_VALUES_STRUCT __RPC_FAR *Values
    )
/*++

Routine Description:

    This routine allocates a block of uuids for UuidCreate to handout.

Arguments:

    Values - Set to contain everything needed to allocate a block of uuids.
             The following fields will be updated here:

    NextTimeLow -   Together with LastTimeLow, this denotes the boundaries
                    of a block of Uuids. The values between NextTimeLow
                    and LastTimeLow are used in a sequence of Uuids returned
                    by UuidCreate().

    LastTimeLow -   See NextTimeLow.

    ClockSequence - Clock sequence field in the uuid.  This is changed
                    when the clock is set backward.

Return Value:

    RPC_S_OK - We successfully allocated a block of uuids.

    RPC_S_OUT_OF_MEMORY - As needed.
--*/
{
    NTSTATUS NtStatus;
    ULARGE_INTEGER Time;
    ULONG Range;
    ULONG Sequence;
    int Tries =3D 0;

    do {
        NtStatus =3D NtAllocateUuids(&Time, &Range, &Sequence, (char *) &Va=
lues->NodeId[0]);

        if (NtStatus =3D=3D STATUS_RETRY)
            {
            Sleep(1);
            }

        Tries++;

        if (Tries =3D=3D 20)
            {
#ifdef DEBUGRPC
            PrintToDebugger("Rpc: NtAllocateUuids retried 20 times!\n");
            ASSERT(Tries < 20);
#endif
            NtStatus =3D STATUS_UNSUCCESSFUL;
            }

        } while(NtStatus =3D=3D STATUS_RETRY);

    if (!NT_SUCCESS(NtStatus))
        {
        return(RPC_S_OUT_OF_MEMORY);
        }

    // NtAllocateUuids keeps time in SYSTEM_TIME format which is 100ns tick=
s since
    // Jan 1, 1601.  UUIDs use time in 100ns ticks since Oct 15, 1582.

    // 17 Days in Oct + 30 (Nov) + 31 (Dec) + 18 years and 5 leap days.

    Time.QuadPart +=3D   (unsigned __int64) (1000*1000*10)       // seconds
                     * (unsigned __int64) (60 * 60 * 24)       // days
                     * (unsigned __int64) (17+30+31+365*18+5); // # of days

    ASSERT(Range);

    Values->ClockSeqHiAndReserved =3D
        RPC_UUID_RESERVED | (((unsigned char) (Sequence >> 8))
        & (unsigned char) RPC_UUID_CLOCK_SEQ_HI_MASK);

    Values->ClockSeqLow =3D (unsigned char) (Sequence & 0x00FF);

    // The order of these assignments is important

    Values->Time.QuadPart =3D Time.QuadPart + (Range - 1);
    Values->AllocatedCount =3D Range;

    if ((Values->NodeId[0] & 0x80) =3D=3D 0)
        {
        return(RPC_S_OK);
        }

    return (RPC_S_UUID_LOCAL_ONLY);
}


NtAllocateUuids() in uuid.c:
https://github.com/tongzx/nt5src/blob/daad8a087a4e75422ec96b7911f1df4669989=
611/Source/XPSP1/NT/base/ntos/ex/uuid.c#L545

/*++

Copyright (c) 1994-1997  Microsoft Corporation

Module Name:

    uuid.c

Abstract:

    This module implements the core time and sequence number allocation
    for UUIDs (exposed to user mode), as well as complete UUID
    creation (exposed to kernel mode only).

              (e.g. RPC Runtime)                (e.g. NTFS)
                      |                              |
                      V                              V
                NtAllocateUuids                 ExUuidCreate
                      |                              |
                      V                              V
                      |                         ExpUuidGetValues
                      |                              |
                      |                              |
                      +------> ExpAllocateUuids <----+
NTSTATUS
NtAllocateUuids (
    OUT PULARGE_INTEGER Time,
    OUT PULONG Range,
    OUT PULONG Sequence,
    OUT PCHAR Seed
    )

/*++

Routine Description:

    This function reserves a range of time for the caller(s) to use for
    handing out Uuids.  As far a possible the same range of time and
    sequence number will never be given out.

    (It's possible to reboot 2^14-1 times and set the clock backwards and t=
hen
    call this allocator and get a duplicate.  Since only the low 14bits of =
the
    sequence number are used in a real uuid.)

Arguments:

    Time - Supplies the address of a variable that will receive the
        start time (SYSTEMTIME format) of the range of time reserved.

    Range - Supplies the address of a variable that will receive the
        number of ticks (100ns) reserved after the value in Time.
        The range reserved is *Time to (*Time + *Range - 1).

    Sequence - Supplies the address of a variable that will receive
        the time sequence number.  This value is used with the associated
        range of time to prevent problems with clocks going backwards.

    Seed - Pointer to a 6 byte buffer. The current seed is written into
this buffer.

Return Value:

    STATUS_SUCCESS is returned if the service is successfully executed.

    STATUS_RETRY is returned if we're unable to reserve a range of
        UUIDs.  This may (?) occur if system clock hasn't advanced
        and the allocator is out of cached values.

    STATUS_ACCESS_VIOLATION is returned if the output parameter for the
        UUID cannot be written.

    STATUS_UNSUCCESSFUL is returned if some other service reports
        an error, most likly the registery.

--*/

{

    KPROCESSOR_MODE PreviousMode;
    NTSTATUS Status;

    LARGE_INTEGER OutputTime;
    ULONG OutputRange;
    ULONG OutputSequence;
    PKTHREAD CurrentThread;

    PAGED_CODE();

    //
    // Establish an exception handler and attempt to write the output
    // arguments. If the write attempt fails, then return
    // the exception code as the service status. Otherwise return success
    // as the service status.
    //

    try {

        //
        // Get previous processor mode and probe arguments if necessary.
        //

        PreviousMode =3D KeGetPreviousMode();
        if (PreviousMode !=3D KernelMode) {
            ProbeForWriteSmallStructure((PVOID)Time, sizeof(LARGE_INTEGER),=
 sizeof(ULONG));
            ProbeForWriteSmallStructure((PVOID)Range, sizeof(ULONG), sizeof=
(ULONG));
            ProbeForWriteSmallStructure((PVOID)Sequence, sizeof(ULONG), siz=
eof(ULONG));
            ProbeForWriteSmallStructure((PVOID)Seed, SEED_SIZE, sizeof(CHAR=
));
            }
    } except (ExSystemExceptionFilter()) {
        return GetExceptionCode();
    }

    // Take the lock, because we're about to update the UUID cache.
    CurrentThread =3D KeGetCurrentThread ();
    KeEnterCriticalRegionThread(CurrentThread);
    ExAcquireFastMutexUnsafe(&ExpUuidLock);

    // Get the sequence number and a range of times that can
    // be used in UUID-generation.

    Status =3D ExpAllocateUuids( &OutputTime, &OutputRange,
&OutputSequence );

    if( !NT_SUCCESS(Status) ) {
        ExReleaseFastMutexUnsafe(&ExpUuidLock);
        KeLeaveCriticalRegionThread(CurrentThread);
        return( Status );
    }

    // If necessary, save the sequence number.  If there's an error,
    // we'll just leave it marked as dirty, and retry on some future call.

    ExpUuidSaveSequenceNumberIf();

    // Release the lock
    ExReleaseFastMutexUnsafe(&ExpUuidLock);
    KeLeaveCriticalRegionThread(CurrentThread);

    //
    // Attempt to store the result of this call into the output parameters.
    // This is done within an exception handler in case output parameters
    // are now invalid.
    //

    try {
        Time->QuadPart =3D OutputTime.QuadPart;
        *Range =3D OutputRange;
        *Sequence =3D OutputSequence;
        RtlCopyMemory((PVOID) Seed, &ExpUuidCachedValues.NodeId[0], SEED_SI=
ZE);
    } except (ExSystemExceptionFilter()) {
        return GetExceptionCode();
    }

    return(STATUS_SUCCESS);
}


NTSTATUS
NtSetUuidSeed (
    IN PCHAR Seed
    )
/*++

Routine Description:

    This routine is used to set the seed used for UUID generation. The seed
    will be set by RPCSS at startup and each time a card is replaced.

Arguments:

    Seed - Pointer to a six byte buffer

Return Value:

    STATUS_SUCCESS is returned if the service is successfully executed.

    STATUS_ACCESS_DENIED If caller doesn't have the permissions to make thi=
s call.
    You need to be logged on as Local System in order to call this API.

    STATUS_ACCESS_VIOLATION is returned if the Seed could not be read.

--*/
{
    NTSTATUS Status;
    LUID AuthenticationId;
    SECURITY_SUBJECT_CONTEXT SubjectContext;
    LUID SystemLuid =3D SYSTEM_LUID;
    BOOLEAN CapturedSubjectContext =3D FALSE;

    PAGED_CODE();

    ASSERT(KeGetPreviousMode() !=3D KernelMode);

    try {
        //
        // Check if the caller has the appropriate permission
        //
        SeCaptureSubjectContext(&SubjectContext);
        CapturedSubjectContext =3D TRUE;

        Status =3D SeQueryAuthenticationIdToken(
                             SeQuerySubjectContextToken(&SubjectContext),
                             &AuthenticationId);
        if (!NT_SUCCESS(Status)) {
            ExRaiseStatus(Status);
            }

        if (RtlCompareMemory(&AuthenticationId, &SystemLuid, sizeof(LUID)) =
!=3D sizeof(LUID)) {
            ExRaiseStatus(STATUS_ACCESS_DENIED);
            }

        //
        // Store the UUID seed
        //
        ProbeForReadSmallStructure(Seed, SEED_SIZE, sizeof(CHAR));
        RtlCopyMemory(&ExpUuidCachedValues.NodeId[0], Seed, SEED_SIZE);

        if ((Seed[0] & 0x80) =3D=3D 0)
            {
            // If the high bit is not set the NodeId is a valid IEEE 802
            // address and should be globally unique.
            ExpUuidCacheValid =3D CACHE_VALID;
            }
        else
            {
            ExpUuidCacheValid =3D CACHE_LOCAL_ONLY;
            }

        Status =3D STATUS_SUCCESS;
    }
    except (EXCEPTION_EXECUTE_HANDLER) {
        Status =3D GetExceptionCode();
    }

    if (CapturedSubjectContext) {
        SeReleaseSubjectContext( &SubjectContext );
        }

    return Status;
}


start.cxx:

https://github.com/tongzx/nt5src/blob/daad8a087a4e75422ec96b7911f1df4669989=
611/Source/XPSP1/NT/com/ole32/dcomss/wrapper/start.cxx#L282C23-L282C41

/*++

Copyright (c) 1995 Microsoft Corporation

Module Name:

    Start.c

Abstract:

    Process init and service controller interaction for dcomss.exe

Author:

    Mario Goertzel    [MarioGo]

Revision History:

    MarioGo    06-14-95    Cloned from the old endpoint mapper.
    MazharM    10-12.98    Add pnp stuff
    TarunA     12-11-98    Removed pnpmngr.h
    a-sergiv   25-08-99    Defined gC2Security for process-wide use

--*/
DealWithDeviceEvent()
/*++
Function Name: DealWithDeviceEvent

Parameters:

Description:

Returns:

--*/
{
    UCHAR MacAddress[8];
    NTSTATUS NtStatus;

    if (getMacAddress(&MacAddress[0]))
        {
        NtStatus =3D NtSetUuidSeed((PCHAR) &MacAddress[0]);
        }
    else
        {
        CookupNodeId(&MacAddress[0]);

        ASSERT(MacAddress[0] & 0x80);

        NtStatus =3D NtSetUuidSeed((PCHAR) &MacAddress[0]);
        }

    if (!NT_SUCCESS(NtStatus))
        {
        #if DBG
        DbgPrint("NtSetUuidSeed failed\n", NtStatus);
        #endif
        }

#if !defined(SPX_IPX_OFF)
    UpdateSap( SAP_CTRL_UPDATE_ADDRESS );
#endif
}


getMacAddress (
    PUCHAR pMacAddress
    )
/*++
Function Name:getMacAddress

Parameters:

Description:

Returns:

--*/
{
    int i;
    UINT fStatus;
    int Size =3D 1024*5;
    PNDIS_ENUM_INTF Interfaces;
    UCHAR       OidVendData[16];

    Interfaces =3D (PNDIS_ENUM_INTF) I_RpcAllocate (Size);
    if (Interfaces =3D=3D 0)
        {
        return FALSE;
        }

    if (NdisEnumerateInterfaces(Interfaces, Size))
        {
        UINT i;

        for (i =3D 0; i < Interfaces->TotalInterfaces; i++)
            {
            PUNICODE_STRING pDeviceName=3D &(Interfaces->Interface[i].Devic=
eName);
            UCHAR           PermMacAddr[6];

            fStatus =3D NdisQueryHwAddress(pDeviceName, pMacAddress, PermMa=
cAddr, &OidVendData[0]);
            if (fStatus && (OidVendData[0] !=3D 0xFF
                || OidVendData[1] !=3D 0xFF
                || OidVendData[2] !=3D 0xFF))
                {
                I_RpcFree (Interfaces);

                return TRUE;
                }
            }
        }

    I_RpcFree (Interfaces);

    return FALSE;
}

As we can see in DealWithDeviceEvent() which is realted to
UuidCreateSequential(it use the seed as the last 48 bits of uuid), the
it calls getMacAddress to obtain MAC address. If OidVendorData's first 6
bytes is 0xff, the function will fail, casing a random value generated
rather than the mac of our adapter. So I guess its related to the virtio
implementation. But I can't identify where the OidVendData is defined.
So I think I should file an issue to virtio dev teams too.

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1119281

Title:
  The virtio network device breaks UuidCreateSequential()

Status in QEMU:
  Expired

Bug description:
  UuidCreateSequential() usually creates version 1 UUIDs (1) which means
  they contain the main network card's MAC address. However when using a
  virtio network card and driver the UUIDs contain random data instead
  of the guest's MAC address. Changing the network card to either the
  default rtl8139 one or the e1000 one fixes the issue.

  Here is the software I have tested this with:
   * qemu 1.1.2+dfsg-5 and 1.4.0~rc0+dfsg-1exp (from Debian Testing and Exp=
erimental respectively)
   * The 0.1-49 and 0.1-52 Windows virtio drivers from https://alt.fedorapr=
oject.org/pub/alt/virtio-win/latest/images/bin/
   * Both a 32-bit Windows XP guest and a 64-bit Windows 7 one.

 =20
  Here is how to test for this issue:
  * Set up a Windows guest with a single network card(2), a virtio one and =
install the corresponding driver.

  * Boot the guest and copy the uuidtest.exe file (see attachement) to
  it

  * On the command line, type 'ipconfig /all'. Give you the correct
  network card's MAC address on a line like the one below:

          Physical Address. . . . . . . . . : 52-54-00-C7-0E-97

  * Run uuidtest.exe. It will show the VM returning a UUID with the
  wrong MAC address, and quite possibly even a multicast MAC address!
  (3). In the example below 'f75292c62787' should have been the MAC
  address. Note that on Windows XP UuidCreateSequential() returns
  RPC_S_UUID_LOCAL_ONLY for virtio cards but that on Windows 7 it
  returns 0.

          UuidCreateSequential() returned 0
          uuid=3D{56e1ffe4-71d8-11e2-b1cc-f75292c62787}
          Got a version 1 UUID
          The UUID does not contain a non-multicast MAC address

  * Reboot and notice uuidtest.exe now reports a different value where
  the MAC address should be.

  * Shut down the VM and switch the network card to rtl8139, install the
  drivers, run uuidtest.exe and notice that the last group of digits
  finally contains the correct MAC address.

 =20
  (1) https://en.wikipedia.org/wiki/Globally_unique_identifier#Algorithm
  (2) Best do it with a single card to avoid confusion over which is the pr=
imary one.
  (3) If the first byte of the address is odd then this is a multicast addr=
ess.
      https://en.wikipedia.org/wiki/MAC_address#Address_details

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1119281/+subscriptions


