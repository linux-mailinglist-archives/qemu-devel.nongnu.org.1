Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B28B881ECDD
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 08:17:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIO9V-0002U4-0A; Wed, 27 Dec 2023 02:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rIO9A-0002LT-4D
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 02:16:12 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rIO92-0002Z6-9x
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 02:16:02 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 56DD8423E8
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 07:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1703661357;
 bh=RqDaQ8nczLwUOp+tShiz8ISZTC7TU8WqIxINc7AQUYs=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=Vuycnhw6kLHKEg/LNhwM1WSSUuPTjIfgj+bjcylXo7eB8EQFMY85T0ZbLsyPO0/YZ
 2Ndbds3Qk4oXSPdvZDa1U/MKeqSjWVtvkn12CZCqI5WwImy5NPGE3BWw0WpHQBa+RJ
 I0jok7vkt9TIA7IyTWyrxpabaVtvfkrnYcH6etgWSokvg6CXuK2J/gMA/XE8BzCDHd
 7QvWByCVOH8jp/+nCXO0KBLjV/DafmrbF1Bpl0YZg7ZwJgvbB2fQDh3T/JcIDOg7nz
 v04OnipyOsepMn780ay+ZS3h4ZqKO3hZeG0N3klXmTZ8UUACl0jdgaGo5UkS/2I8Bn
 FyBFH4IMGGfKg==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 29285821FD
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 07:15:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Dec 2023 07:08:02 -0000
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
Message-Id: <170366088282.603301.3593231943675401947.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 1119281] Re: The virtio network device breaks
 UuidCreateSequential()
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b";
 Instance="launchpad-scripts"
X-Launchpad-Hash: c0135b4b88f306d7f42919c764d96ea6859e1d98
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
uuid.c:
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


start.cxx:
https://github.com/tongzx/nt5src/blob/daad8a087a4e75422ec96b7911f1df4669989=
611/Source/XPSP1/NT/com/ole32/dcomss/wrapper/start.cxx#L282C23-L282C41

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

As see can see functions realted to UuidCreateSequential(it use the seed
ad the last 48 bits of uuid), the following code showed how Windows
obtain MAC address and OidVendorData, if OidVendorData's first 6 bytes
is 0xff, the function will fail, casing a random value generated rather
than the mac of our adapter. So I guess its related to the virtio
implementation. But I can't identify where the OidVendData is defined.
So I think I should file a issue to virtio dev teams too.

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


